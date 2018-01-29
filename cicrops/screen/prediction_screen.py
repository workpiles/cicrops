from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from kivy.uix.screenmanager import Screen
from kivy.properties import StringProperty
from kivy.core.text import Label as CoreLabel
from kivy.graphics import *
from kivy.clock import Clock
from rank_classifier import RankClassifier, Predictions
from workload_monitor import WorkloadMonitor
import time
import iod.switches as sw

LABEL1 = ['2L', 'L', 'M', 'S', '2S', 'BL', 'BM', 'BS', 'C', '?']
LABEL2 = ['A', 'A', 'A', 'A', 'A', 'B', 'B', 'B', 'C', '?']

PX2CM_FACTOR = 0.083
MAX_RESIZE_RATIO = 0.2

class PredictionScreen(Screen):
	_fps = StringProperty()

	def __init__(self, cam, sws, **kwargs):
		super(Screen, self).__init__(**kwargs)
		self._updateTime = 0
		self._fps = "FPS:00.00"

		self._cam = cam
		self._label1 = False
		self._looper = None
		self._classifier = RankClassifier()
		self._sws = sws
		self._wm = WorkloadMonitor()

	def on_enter(self):
		self._looper = Clock.schedule_interval(self.on_loop, 0.3)

	def on_leave(self):
		self._looper.cancel()
		
	def capture(self):
		result = self._cam.capture()
		if not result.moving and len(result.images) > 0:
			h_ratio = self._sws.length_meter.get_balance() * MAX_RESIZE_RATIO
			w_ratio = self._sws.width_meter.get_balance() * MAX_RESIZE_RATIO
			predictions = self._classifier.predict(result.images, result.areas, h_ratio, w_ratio)
			self.draw_box_and_label(result.images, result.rects, result.centers, predictions)
			self._wm.count(predictions.get_top_labels())
		else:
			self.draw_box(result.rects)
			if len(result.images) == 0:
				self._wm.clear()
			
	def on_loop(self, dt):
		select = self._sws.select_meter.get_balance()
		if select < 0 :
			self._label1 = False
		else:
			self._label1 = True

		mode = self._sws.get_mode_str()
		if mode=='prediction':
			self.capture()
		else:
			self.manager.current = mode

	def draw_box_and_label(self, images, rects, centers, predictions):
		elapsed = time.time() - self._updateTime
		fps = 1.0 / elapsed

		canvas = self.ids.monitor.canvas
		canvas.clear()
		for img, rect, c, p, acc in zip(images, rects, centers, predictions.get_all_labels(), predictions.get_all_accuraces()):
			#Color
			if p[0] < 5:
				color = (0.75, 0.40, 0.62, 1)
			elif p[0] >= 5 and p[0] < 9:
				color = (0.40, 0.75, 0.62, 1)
			elif p[0] >= 8:
				color = (0.7, 0.7, 0.7, 1)
			r,g,b,_ = color

			label_text = LABEL1[p[0]] if self._label1 else LABEL2[p[0]]
			label = CoreLabel(text="Rank  :%s"%(label_text), font_size=30, color=color, italic=True)
			label.refresh()
			texture = label.texture
			texture_size = list(texture.size)

			h,w,_ = img.shape
			cm = h * PX2CM_FACTOR
			length = CoreLabel(text="Length:%.1fcm"%(cm), font_size=30, color=color, italic=True)
			length.refresh()
			texture2 = length.texture
			texture2_size = list(texture2.size)

			accuracy = CoreLabel(text="Accuracy:%d"%(int(acc[0]*100))+"%", font_size=30, color=color, italic=True)
			accuracy.refresh()
			texture3 = accuracy.texture
			texture3_size = list(texture3.size)
			
			label2_text = LABEL1[p[1]] if self._label1 else LABEL2[p[1]]
			label2 = CoreLabel(text="(%s)"%(label2_text), font_size=20,italic=True)
			label2.refresh()
			texture4 = label2.texture
			texture4_size = list(texture4.size)
			with canvas:
				Color(r, g, b)
				Line(points=rect, width=3, close=True)
				Line(points=[(c[0]-5, 110), (c[0]-35, 5), (c[0] + texture2_size[0], 5)], width=1, color=color)
				Rectangle(texture=texture, pos=(c[0], texture3_size[1]*2+5), size=texture_size)
				Rectangle(texture=texture3, pos=(c[0]-7 , texture2_size[1]+5), size=texture3_size) 
				Rectangle(texture=texture2, pos=(c[0]-14, 5), size=texture2_size)
				Color(0.7,0.7,0.7)
				Rectangle(texture=texture4, pos=(c[0] + texture_size[0] + 10, texture3_size[1]*2+10), size=texture4_size)

		self._fps = "FPS:%02.2f"%(fps)
		self._updateTime = time.time()



	def draw_box(self, rects):
		elapsed = time.time() - self._updateTime
		fps = 1.0 / elapsed

		canvas = self.ids.monitor.canvas
		canvas.clear()
		for rect in rects:
			with canvas:
				Color(0.5, 0.76, 0.86)
				Line(points=rect, width=2, close=True)

		self._fps = "FPS:%02.2f"%(fps)
		self._updateTime = time.time()

