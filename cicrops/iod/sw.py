from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

import RPi.GPIO as GPIO

NUM_OF_SAMPLING = 3

class SW(object):
	def __init__(self, pin):
		GPIO.setmode(GPIO.BCM)
		GPIO.setup(pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

		self._pin = pin
		self._buffer = [1 for i in xrange(NUM_OF_SAMPLING)]
		self._buffer_ite = 0
		self._is_on = False
		self._listener = None

	def update(self):
		self._buffer[self._buffer_ite] = GPIO.input(self._pin)
		self._buffer_ite = (self._buffer_ite + 1) % len(self._buffer)

		state = self._check_state()
		if state is not None:
			if self._is_on != state and self._listener is not None:
				self._listener(state)
			self._is_on = state
		return self._is_on

	def _check_state(self):
		total = 0
		for i in xrange(NUM_OF_SAMPLING):
			total += self._buffer[i]
		
		if total==0:
			return True
		elif total==NUM_OF_SAMPLING:
			return False
		else:
			return None

	def register_listener(self, listener):
		self._listener = listener

	def unregister_listener(self):
		self._listener = None
			
	def is_on(self):
		return self._is_on
