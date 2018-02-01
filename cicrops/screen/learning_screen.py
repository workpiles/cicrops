from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from kivy.uix.screenmanager import Screen
from kivy.properties import StringProperty
from kivy.core.text import Label as CoreLabel
from kivy.graphics.texture import Texture
from kivy.graphics import Rectangle
from kivy.clock import Clock
import iod.switches as sw
from Queue import Queue
import time
import cv2
import os

LABEL = ['2L', 'L', 'M', 'S', '2S', 'BL', 'BM', 'BS', 'C', 'None']

STATE_SPLASH = 0
STATE_CAPTURING = 1
STATE_CAPTURED = 2
STATE_SAVING = 3

SAVE_DIR = "./database"

class LearningScreen(Screen):
	_center_text = StringProperty()
	_label_text = StringProperty()

	def __init__(self, cam, sws, **kwargs):
		super(Screen, self).__init__(**kwargs)

		self._cam = cam
		self._looper = None
		self._label_id = 0
		self._center_text = ''
		self._label_text = ''
		self._req_commit = Queue(1)
		self._sws = sws
		self._captured_images = None

	def on_enter(self):
		self._sws.enter_sw.register_listener(self.on_btn_changed)
		self._looper = Clock.schedule_interval(self.on_loop, 0.3)
		self._center_text = 'Learning Mode'
		self._label_text = LABEL[self._label_id]
		self._splash_wait = 7
		self._state = STATE_SPLASH

	def on_btn_changed(self, on_event):
		if on_event:
			self._req_commit.put(True)

	def on_leave(self):
		self._sws.enter_sw.unregister_listener()
		self._looper.cancel()

	def draw_captured_images(self, images, select):
		draw_x_pos = 10
		draw_y_pos = self.height - 10
		
		canvas = self.ids.monitor.canvas
		canvas.clear()
		with canvas:
			for img in images:
				img = cv2.flip(img, 0)
				texture = Texture.create(size=(img.shape[1], img.shape[0]), colorfmt="rgb")
				texture.blit_buffer(img.tostring(), bufferfmt="ubyte", colorfmt="rgb")
				texture_size = list(texture.size)

				Rectangle(texture=texture, pos=(draw_x_pos, draw_y_pos - img.shape[0]), size=texture_size)

				draw_x_pos += texture_size[0] + 10

			text = CoreLabel(text="Would you like to add the images?", color=(0,0,0,1), font_size=40)
			text.refresh()
			texture = text.texture
			texture_size = list(texture.size)
			Rectangle(texture=texture, pos=(10,500), size=texture_size)

			label_text = CoreLabel(text="Label : %s"%(LABEL[self._label_id]), color=(0,0,0,1), font_size=70)
			label_text.refresh()
			texture = label_text.texture
			texture_size = list(texture.size)
			Rectangle(texture=texture, pos=(10,410), size=texture_size)

			if select < 0:
				yes_text = CoreLabel(text="YES", color=(1.0, 0.4, 0.7, 1.0), font_size=50)
				yes_text.refresh()
				texture = yes_text.texture
				texture_size = list(texture.size)
				Rectangle(texture=texture, pos=(100,320), size=texture_size)

				no_text = CoreLabel(text="NO", color=(0.4, 0.7, 1.0, 1.0), font_size=30)
				no_text.refresh()
				texture = no_text.texture
				texture_size = list(texture.size)
				Rectangle(texture=texture, pos=(300,320), size=texture_size)

			else:
				yes_text = CoreLabel(text="YES", color=(1.0, 0.4, 0.7, 1.0), font_size=30)
				yes_text.refresh()
				texture = yes_text.texture
				texture_size = list(texture.size)
				Rectangle(texture=texture, pos=(100,320), size=texture_size)

				no_text = CoreLabel(text="NO", color=(0.4, 0.7, 1.0, 1.0), font_size=50)
				no_text.refresh()
				texture = no_text.texture
				texture_size = list(texture.size)
				Rectangle(texture=texture, pos=(300,320), size=texture_size)

			s_text = CoreLabel(text="/", color=(0, 0, 0, 1), font_size=30)
			s_text.refresh()
			texture = s_text.texture
			texture_size = list(texture.size)
			Rectangle(texture=texture, pos=(220,320), size=texture_size)

	def canvas_clear(self):
		canvas = self.ids.monitor.canvas
		canvas.clear()

	def _task(self):
		if self._state==STATE_SPLASH:
			self._splash_wait -= 1
			if self._splash_wait == 0:
				self._center_text = ""
				self._state = STATE_CAPTURING
		elif self._state==STATE_CAPTURING:
			captured = self.capture()
			if captured is not None:
				self._captured_images = captured
				self._state = STATE_CAPTURED
		elif self._state==STATE_CAPTURED:
			select = self._sws.select_meter.get_balance()
			self.draw_captured_images(self._captured_images, select)
			if not self._req_commit.empty():
				self._req_commit.get(block=False)
				if select < 0:
					self._state = STATE_SAVING
				else:
					self._state = STATE_CAPTURING
				self.canvas_clear()
		elif self._state==STATE_SAVING:
			for i,img in enumerate(self._captured_images):
				name = LABEL[self._label_id] + time.strftime("_%Y%m%d%H%M%S", time.localtime())
				name = "%s%d.jpg"%(name,i)
				path = os.path.join(SAVE_DIR,name)
				cv2.imwrite(path, img)
			self._state = STATE_CAPTURING


	def on_loop(self, dt):
		start = time.time()
		if self._state==STATE_CAPTURING:
			v = self._sws.select_meter.get_volume()
			self._label_id = int(v*9)
			self._label_text = LABEL[self._label_id]

		mode = self._sws.get_mode_str()
		if mode=='learning':
			self._task()
		else:
			self.manager.current = mode
		
	def capture(self):
		result = self._cam.capture()

		if not self._req_commit.empty():
			self._req_commit.get(block=False)
			if not result.moving and len(result.images) > 0:
				return result.images
			
		return None
