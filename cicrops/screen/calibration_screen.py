from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from kivy.uix.screenmanager import Screen
from kivy.graphics import Color, Rectangle
from kivy.clock import Clock

class CalibrationScreen(Screen):
	def __init__(self, cam, **kwargs):
		super(Screen, self).__init__(**kwargs)
		self._cam = cam

	def on_pre_enter(self):
		pass
	
	def on_enter(self):
		Clock.schedule_once(self.start_calibration, 2)
	
	def start_calibration(self, dt):
		tl, tr, bl, br = self._cam.calibration()
		
		with self.canvas:
			Color(1., 0, 0)
			offset_x = (self.width // 2) - 20
			offset_y = (self.height // 2) - 20
			Rectangle(pos=(offset_x + tl[0]*40, offset_y + (1.0 - tl[1])*40), size=(20, 20))
			Rectangle(pos=(offset_x + tr[0]*40, offset_y + (1.0 - tr[1])*40), size=(20, 20))
			Rectangle(pos=(offset_x + bl[0]*40, offset_y + (1.0 - bl[1])*40), size=(20, 20))
			Rectangle(pos=(offset_x + br[0]*40, offset_y + (1.0 - br[1])*40), size=(20, 20))
			
		Clock.schedule_once(self.end_calibration, 4)
	
	def end_calibration(self, dt):
		self.manager.current = 'prediction'
		self.manager.remove_widget(self)

	def on_pre_leave(self):
		pass

	def on_leave(self):
		pass
