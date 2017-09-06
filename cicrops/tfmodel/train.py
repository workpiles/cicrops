from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tensorflow as tf
import numpy as np
from model import inference, loss, train
from input_data import get_input_pipeline
import time
from util import makeTrialOutputPath

FLAGS = tf.app.flags.FLAGS
tf.app.flags.DEFINE_integer('batch_size', 100, '')
tf.app.flags.DEFINE_integer('max_steps', 50000, '')
tf.app.flags.DEFINE_float('learning_rate', 1e-3, '')
tf.app.flags.DEFINE_string('restore', None, '')
tf.app.flags.DEFINE_string('job_dir', './','')
tf.app.flags.DEFINE_float('keep_prob', 0.5, '')
tf.app.flags.DEFINE_integer('input_height', '72', '')
tf.app.flags.DEFINE_integer('input_width', '24', '')
tf.app.flags.DEFINE_integer('input_ch', '1','')
tf.app.flags.DEFINE_string('dataset_dir', './dataset', '')


with tf.Graph().as_default():
	output_path = makeTrialOutputPath(FLAGS.job_dir)
	images, labels, lengths, widths, areas = get_input_pipeline(FLAGS.batch_size, 'train', FLAGS.input_height, FLAGS.input_width, FLAGS.input_ch, root=FLAGS.dataset_dir)

	ph_keep_prob = tf.placeholder(tf.float32)
	ph_is_training = tf.placeholder(tf.bool)

	logits = inference(images, lengths, widths, areas, ph_keep_prob, ph_is_training)
	loss = loss(logits, labels)

	train_op = train(loss, FLAGS.learning_rate)

	sess = tf.Session()
	coord = tf.train.Coordinator()
	threads = tf.train.start_queue_runners(sess=sess, coord=coord)

	sess.run(tf.global_variables_initializer())
	saver = tf.train.Saver()
	if FLAGS.restore is not None:
		saver.restore(sess, FLAGS.restore)

	summary_op = tf.summary.merge_all()
	summary_writer = tf.summary.FileWriter(output_path + '/summary', sess.graph)

	start_time = time.time()
	try:
		for step in xrange(FLAGS.max_steps):
			feed_dict = {ph_keep_prob: FLAGS.keep_prob, ph_is_training: True}
			_, ce = sess.run([train_op, loss], feed_dict=feed_dict)

			if (step+1)%100==0:
				feed_dict = {ph_keep_prob: 1.0, ph_is_training: False}
				summary_str = sess.run(summary_op, feed_dict=feed_dict)
				summary_writer.add_summary(summary_str, step)

				if (step+1)%500==0:
					duration = time.time() - start_time
					print('Step %d: Cross Entropy=%g (%.3f sec)'%(step, ce, duration))
					saver.save(sess, output_path + '/model.ckpt', global_step=step)
	
					start_time = time.time()

	finally:
		coord.request_stop()

	coord.join(threads)
	sess.close()

