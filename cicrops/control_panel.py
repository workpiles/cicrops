from __future__ import absolute_import
from __future__ import print_function
from __future__ import division

from iod.potentiometer import Potentiometer
from iod.mcp3008 import MCP3008
from iod.sw import SW
from iod.rotary_sw import RotarySW
from threading import Lock

class ControlPanel():
	__instance = None
	__lock = Lock()

	enter_sw = SW(13)
	mode_sw = RotarySW([21, 26, 20])
		
	mcp = MCP3008()
		
	length_meter = Potentiometer(mcp, 1)
	width_meter = Potentiometer(mcp, 2)
	select_meter = Potentiometer(mcp, 0)

	def __new__(cls):
		with cls.__lock:
			if cls.__instance is None:
				cls.__instance = object.__new__(cls)
		return cls.__instance

	def update(self):
		self.enter_sw.update()
		self.mode_sw.update()
			
		self.length_meter.update()
		self.width_meter.update()
		self.select_meter.update()
		
