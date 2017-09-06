from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from kivy.uix.screenmanager import Screen
from kivy.clock import Clock

SPLASH_TIME = 5
class SplashScreen(Screen):
	def __init__(self, **kwargs):
		super(Screen, self).__init__(**kwargs)

	def on_pre_enter(self):
		pass
	
	def on_enter(self):
		Clock.schedule_once(self.on_dismiss, SPLASH_TIME)

	def on_dismiss(self, dt):
		self.manager.current = 'calibration'
		self.manager.remove_widget(self)

	def on_pre_leave(self):
		pass

	def on_leave(self):
		pass

