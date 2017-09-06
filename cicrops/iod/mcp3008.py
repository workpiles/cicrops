from __future__ import absolute_import
from __future__ import print_function
from __future__ import division
import spidev
import time

SPI_FREQUENCY = 1350000
#SPI_FREQUENCY = 3000000

TX_SINGLE_CH0 = 0x80
NUM_OF_SAMPLING = 4
MAX_VALUE = 0x03FF

class MCP3008(object):
	def __init__(self, bus=0):
		self.spi = spidev.SpiDev()
		self.spi.open(0, bus)
		self.spi.max_speed_hz = SPI_FREQUENCY

	def readSingle(self, ch):
		value = 0
		for i in xrange(NUM_OF_SAMPLING):
			tx_ch = TX_SINGLE_CH0 + (ch << 4)
			rxbuf = self.spi.xfer2([0x01, tx_ch, 0x00])
			value += ((rxbuf[1] & 0x03) << 8) + rxbuf[2]
		return (value // NUM_OF_SAMPLING)

	def get_max_value(self):
		return MAX_VALUE

if __name__ == '__main__':
	dev =  [MCP3008(0), MCP3008(1)]

	data = [[],[]]
	for i in xrange(100):
		data[0] = [0, 0, 0, 0, 0, 0, 0, 0]
		data[1] = [0, 0, 0, 0, 0, 0, 0, 0]
		for j in xrange(2):
			for i in xrange(8):
				moi = 0
				for n in xrange(10):
					moi += dev[j].readSingle(i)
					time.sleep(0.001)
				data[j][i] = moi//10
		print(data)
		time.sleep(0.1)

