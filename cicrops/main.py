from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from table_camera import TableCamera
import iod.switches as sw
import time
import kivy
import cv2
kivy.require('1.9.1')

from kivy.config import Config
Config.set('graphics', 'width', '1920')
Config.set('graphics', 'height', '1080')
#Config.set('graphics', 'rotation', '180')

from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen, NoTransition
#from kivy.graphics import *
#from kivy.uix.label import Label
#from kivy.core.text import Label as CoreLabel
from kivy.clock import Clock
from kivy.core.window import Window
from screen import *

Window.clearcolor = (1, 1, 1, 1)
Window.fullscreen = False

class Main(App):
	def __init__(self, **kwargs):
		super(Main, self).__init__(**kwargs)

	def build(self):
		cam = TableCamera((Config.getint('graphics', 'width'), Config.getint('graphics', 'height')))
		self._cam = cam
		self._sws = sw.Switches()
		self.sm = ScreenManager(transition=NoTransition())
		self.sm.add_widget(InfomationScreen(name='infomation'))
		self.sm.add_widget(LearningScreen(camera=cam, name='learning'))
		self.sm.add_widget(PredictionScreen(camera=cam, name='prediction'))
		self.sm.add_widget(CalibrationScreen(camera=cam, name='calibration'))
		self.sm.add_widget(SplashScreen(name='splash'))
		self.sm.current = 'splash'
		Clock.schedule_interval(self.on_loop, 0.001)
		self._old = time.time()
		return self.sm

	def on_loop(self, dt):
		self._sws.update()
		
	def on_stop(self):
		self._cam.release()

if __name__ == '__main__':
	Main().run()

