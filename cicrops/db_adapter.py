from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import sqlite3
import datetime

DBNAME = 'database/log.db'
ALL_COLUMN = 'label_2L, label_L, label_M, label_S, label_2S, label_BL, label_BM, label_BS, label_C'

def insert(data):
	conn = sqlite3.connect(DBNAME)
	c = conn.cursor()

	sql = 'insert into log ('+ALL_COLUMN+') values (?,?,?,?,?,?,?,?,?)'
	c.execute(sql, data)
	conn.commit()
	conn.close()

def get_total(start_day, end_day=None):
	if end_day is None:
		end_day = start_day

	conn = sqlite3.connect(DBNAME)
	c = conn.cursor()
	#sql = "select sum(label_2L), sum(label_L), sum(label_M), sum(label_S), sum(label_2S), sum(label_BL), sum(label_BM), sum(label_BS), sum(label_C) from log where created_at >= '" + dt.strftime('%Y-%m-%d 00:00:00') + "' and created_at <= '" + dt.strftime('%Y-%m-%d 23:59:59') + "'"
	sql = "select sum(label_2L)+sum(label_L)+sum(label_M)+sum(label_S)+sum(label_2S)+sum(label_BL)+sum(label_BM)+sum(label_BS)+sum(label_C) from log where created_at >= '" + start_day.strftime('%Y-%m-%d 00:00:00') + "' and created_at <= '" + end_day.strftime('%Y-%m-%d 23:59:59') + "'"
	c.execute(sql)

	num = c.fetchone()[0]
	conn.close()
	return num if num is not None else 0


def create():
	conn = sqlite3.connect(DBNAME)
	c = conn.cursor()
	c.execute('''create table log (
								id integer primary key autoincrement,
								label_2L integer,
								label_L integer,
								label_M integer,
								label_S integer,
								label_2S integer,
								label_BL integer,
								label_BM integer,
								label_BS integer,
								label_C integer,
								created_at timestamp default (datetime('now', 'localtime')))''')
								
	conn.commit()
	conn.close()

if __name__=='__main__':
	date = datetime.date(2017, 9, 4)
	s = get_total(date, datetime.date(2017, 9, 30))
	print(s)

