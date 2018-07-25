from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

import RPi.GPIO as GPIO
from iod.sw import SW


class RotarySW(object):
	def __init__(self, pins):
		self._switches = []
		for pin in pins:
			self._switches.append(SW(pin))
		self._old = 0
		self._new = 0
	
	def get_position(self):
		for i,sw in enumerate(self._switches):
			if sw.is_on():
				return i
		return -1

	def update(self):
		self._old = self._new
		for i, sw in enumerate(self._switches):
			sw.update()
			if sw.is_on():
				self._new = i

	def is_changed(self):
		return self._old is not self._new

