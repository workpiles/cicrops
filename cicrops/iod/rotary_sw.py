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
	
	def get_position(self):
		for i,sw in enumerate(self._switches):
			if sw.is_on():
				return i
		return -1

	def update(self):
		for sw in self._switches:
			sw.update()
