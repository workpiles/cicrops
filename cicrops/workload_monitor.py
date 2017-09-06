from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import db_adapter as db
import time

STATE_WAIT = 0
STATE_COUNTING = 1

CLASSES = 9 #without None

class WorkloadMonitor():
	def __init__(self):
		#self._count = [ 0 for i in xrange(n_classes)]
		self._state = STATE_WAIT

		self._label_buffer = [0 for i in xrange(CLASSES)]
		self._count_buffer = 0

	def count(self, labels):
		if 9 in labels : #None
			return

		if self._state==STATE_WAIT and len(labels) > 0:
			self._count(labels)
			self._state = STATE_COUNTING
		else:
			if len(labels) > 0:
				self._count(labels)
			else:
				self._commit()
				self._state = STATE_WAIT
	
	def clear(self):
		if self._state==STATE_COUNTING and self._count_buffer > 0:
			self._commit()
		self._state = STATE_WAIT
				
	def _count(self, labels):
		if self._count_buffer <= len(labels):
			buf = [0 for i in xrange(CLASSES)]
			for i in labels:
				buf[i] += 1
			self._label_buffer = buf
			self._count_buffer = len(labels)

	def _commit(self):
		print("commit", self._label_buffer)
		db.insert(self._label_buffer)
		self._label_buffer = None
		self._count_buffer = 0

if __name__=='__main__':

	conn = sqlite3.connect("database/log.db")
	c = conn.cursor()
	for row in c.execute("select sum(label_M) from log"):
		print(row)
	conn.close()

#	wc = WorkloadMonitor()
#	start = time.time()
#	wc.count([1,3])
#	wc.count([1,2,3])
#	wc.count([1,2,3,6])
#	wc.count([1,2,3,6,7,9])
#	wc.count([1,4,5])
#	wc.count([1,4])
#	wc.count([1])
#	wc.count([])
#	print("elapsed:%f"%(time.time()-start))

