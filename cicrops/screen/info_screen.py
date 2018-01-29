from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from kivy.uix.screenmanager import Screen
from kivy.properties import StringProperty
from kivy.core.text import Label as CoreLabel
from kivy.graphics import *
from kivy.uix.button import Button
from kivy.clock import Clock
from iod.switches import Switches
import time
import datetime
import db_adapter as db

STATE_SPLASH = 0
STATE_INFO = 1

class InfomationScreen(Screen):
	_center_text = StringProperty()

	def __init__(self, sws, **kwargs):
		super(Screen, self).__init__(**kwargs)

		self._state = STATE_SPLASH
		self._looper = None
		self._sws = sws

	def on_enter(self):
		self._center_text = "Infomation"
		self._state = STATE_SPLASH
		self._splash_wait = 10
		self._looper = Clock.schedule_interval(self.on_loop, 0.3)

		self.draw_chart()

	def draw_chart(self):
		canvas = self.ids.chart_layout.canvas
		canvas.clear()
		with canvas:
			Color(0.1, 1.0, 0)
			x = 50 + 200
			today = datetime.date.today()
			for i in xrange(1,31): #TODO range is wrong
				v = db.get_total(datetime.date(today.year, today.month, i))
				v = int(v * 0.88)
				Rectangle(pos=(x-10, 100), size=(40, v))
				x += 50

			Color(0,0,0)
			Line(points=[100,100, 1820, 100], width=4, close=False)
			Line(points=[200,980, 200, 80], width=4, close=False)

			Color(0, 0, 0)
			x = 50 + 200
			for i in xrange(1,31): #TODO range is wrong
				day_text = CoreLabel(text=str(i), font_size=25, color=(0.3,0.3,0.3,1.0), italic=True)
				day_text.refresh()
				texture = day_text.texture
				texture_size = list(texture.size)

				Rectangle(texture=texture, pos=(x, 50), size=texture_size)
				x += 50

			y_axis = CoreLabel(text=str(500), font_size=25, color=(0.3,0.3,0.3,1.0), italic=True)
			y_axis.refresh()
			texture = y_axis.texture
			texture_size = list(texture.size)
			Rectangle(texture=texture, pos=(150, 540 - texture_size[1]//2), size=texture_size)

			month = time.strftime("%b",time.localtime())
			month_text = CoreLabel(text=month, font_size=60, color=(0.5,0.5,0.5,1.0), bold=True)
			month_text.refresh()
			texture = month_text.texture
			texture_size = list(texture.size)
			Rectangle(texture=texture, pos=(50, 980), size=texture_size)


	def on_leave(self):
		self._looper.cancel()

	def on_loop(self, dt):
		mode = self._sws.get_mode_str()
		if mode=="infomation":
			if self._state==STATE_SPLASH:
				self._splash_wait -= 1
				if self._splash_wait < 0:
					self._center_text = ""
					self._state = STATE_INFO
			elif self._state==STATE_INFO:
				pass
		else:
			self.manager.current = mode

