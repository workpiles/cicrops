from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from table_camera import TableCamera
import iod.switches as sw
import time
import kivy
import cv2

from kivy.config import Config
Config.set('graphics', 'width', '1920')
Config.set('graphics', 'height', '1080')
#Config.set('graphics', 'rotation', '180')

from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen, NoTransition
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
		sws = sw.Switches()
		sm = ScreenManager(transition=NoTransition())
		#sm.add_widget(InfomationScreen(sws, name='infomation'))
		sm.add_widget(SplashScreen(name='splash'))
		sm.add_widget(CalibrationScreen(cam, sws, name='calibration'))
		sm.add_widget(PredictionScreen(cam, sws, name='prediction'))
		sm.add_widget(LearningScreen(cam, sws, name='learning'))
		sm.current = 'splash'

		self._cam = cam
		self._sws = sws
		Clock.schedule_interval(self.on_loop, 0.001)
		return sm

	def on_loop(self, dt):
		self._sws.update()
		
	def on_stop(self):
		self._cam.release()

if __name__ == '__main__':
	Main().run()
