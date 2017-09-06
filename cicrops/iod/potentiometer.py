from __future__ import absolute_import
from __future__ import print_function
from __future__ import division


class Potentiometer(object):
	def __init__(self, driver, ch, max_level = 1):
		self._value = 0
		self._driver = driver
		self._driver_ch = ch
		self._max_level = max_level

	def get_balance(self):
		v = self.get_volume()
		v = (v - 0.46) * 2 #adjust 0.5->0.46
		v = (v / 0.9) if (v/0.9) <= 1.0 else 1.0
		return round(v,2)

	def get_volume(self):
		return 1.0 - self._value / self._driver.get_max_value()

	def get_value(self):
		return self._value

	def get_max_level(self):
		return self._max_level

	def update(self):
		self._value = self._driver.readSingle(self._driver_ch)
		return self._value
	
	def get_level(self):
		resolution = self._driver.get_max_value() // self._max_level
		return (self._value // resolution)


