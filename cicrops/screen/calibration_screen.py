from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from kivy.uix.screenmanager import Screen
from kivy.clock import Clock
import iod.switches as sw

class CalibrationScreen(Screen):
	def __init__(self, **kwargs):
		super(Screen, self).__init__(**kwargs)
		self._cam = kwargs['camera']
		self._sws = sw.Switches()

	def on_pre_enter(self):
		pass
	
	def on_enter(self):
		Clock.schedule_once(self.on_calibration, 2)
	
	def on_calibration(self, dt):
		self._cam.calibration()
		
		self.manager.current = self._sws.get_mode_str()
		self.manager.remove_widget(self)

	def on_pre_leave(self):
		pass

	def on_leave(self):
		pass
