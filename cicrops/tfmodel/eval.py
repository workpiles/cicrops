from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tensorflow as tf
import numpy as np
from model import inference 
from input_data import get_input_pipeline
import time
from util import makeTrialOutputPath

FLAGS = tf.app.flags.FLAGS
tf.app.flags.DEFINE_integer('batch_size', '100','')
tf.app.flags.DEFINE_string('restore', None, '')
tf.app.flags.DEFINE_string('job_dir', './','')
tf.app.flags.DEFINE_integer('input_height', '72', '')
tf.app.flags.DEFINE_integer('input_width', '24', '')
tf.app.flags.DEFINE_integer('input_ch', '1','')
tf.app.flags.DEFINE_string('dataset_dir', './dataset', '')


with tf.Graph().as_default():
	output_path = makeTrialOutputPath(FLAGS.job_dir)
	images, labels, lengths, widths, areas = get_input_pipeline(FLAGS.batch_size, 'validation', FLAGS.input_height, FLAGS.input_width, FLAGS.input_ch, root=FLAGS.dataset_dir)

	logits = tf.nn.softmax(inference(images, lengths, widths, areas, 1.0, False))
	correct_op = tf.reduce_sum(tf.cast(tf.nn.in_top_k(logits, labels, 1), tf.int32))

	sess = tf.Session()
	coord = tf.train.Coordinator()
	threads = tf.train.start_queue_runners(sess=sess, coord=coord)

	sess.run(tf.global_variables_initializer())
	saver = tf.train.Saver()
	saver.restore(sess, FLAGS.restore)

	start_time = time.time()
	try:
		#TEST
		n = 8000//FLAGS.batch_size
		corrects = 0
		for i in range(n):
			corrects += sess.run(correct_op)
		print('Test Accuracy: %g'%(corrects/8000))

	finally:
		coord.request_stop()

	coord.join(threads)
	sess.close()

