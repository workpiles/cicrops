from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tensorflow as tf
from tensorflow.python.lib.io import file_io
import numpy as np
from model import inference 

FLAGS = tf.app.flags.FLAGS
tf.app.flags.DEFINE_integer('input_height', '72', '')
tf.app.flags.DEFINE_integer('input_width', '24', '')
tf.app.flags.DEFINE_integer('input_ch', '1','')
tf.app.flags.DEFINE_string('restore', None, '')
tf.app.flags.DEFINE_bool('as_text', False, '')

if file_io.file_exists('./model'):
	file_io.delete_recursively('./model')
builder = tf.saved_model.builder.SavedModelBuilder('./model')

with tf.Session(graph=tf.Graph()) as sess:
	ph_images = tf.placeholder(tf.float32, shape=[None, FLAGS.input_height, FLAGS.input_width, FLAGS.input_ch])
	ph_lengths = tf.placeholder(tf.float32)
	ph_widths = tf.placeholder(tf.float32)
	ph_areas = tf.placeholder(tf.float32)

	logits = inference(ph_images, ph_lengths, ph_widths, ph_areas, 1.0, False)
	accuracies = tf.nn.softmax(logits, name='accuracies')
	_,predicts = tf.nn.top_k(accuracies, k=2, name='predicts')

	saver = tf.train.Saver()
	saver.restore(sess, FLAGS.restore)

	summary_op = tf.summary.merge_all()
	summary_writer = tf.summary.FileWriter('./test_summary', sess.graph)

	input_signatures = {
		'images': tf.saved_model.utils.build_tensor_info(ph_images),
		'lengths': tf.saved_model.utils.build_tensor_info(ph_lengths),
		'widths': tf.saved_model.utils.build_tensor_info(ph_widths),
		'areas': tf.saved_model.utils.build_tensor_info(ph_areas),
	}

	output_signatures = {
		'predicts': tf.saved_model.utils.build_tensor_info(predicts),
		'accuracies': tf.saved_model.utils.build_tensor_info(accuracies),
	}

	signature_def = tf.saved_model.signature_def_utils.build_signature_def(
		input_signatures,
		output_signatures,
		tf.saved_model.signature_constants.PREDICT_METHOD_NAME
	)

	builder.add_meta_graph_and_variables(sess,
		[tf.saved_model.tag_constants.SERVING],
		signature_def_map={tf.saved_model.signature_constants.DEFAULT_SERVING_SIGNATURE_DEF_KEY: signature_def},
	)
	
	builder.save(as_text=FLAGS.as_text) 

