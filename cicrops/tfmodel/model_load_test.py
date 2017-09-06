from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tensorflow as tf
from tensorflow.python.saved_model import builder as saved_model_builder
from input_data import get_input_pipeline

def get_tensor_from_tensor_info(sess, tensor_info):
	#Instead of tf.saved_model.utils.get_tensor_from_tensor_info[TF r1.3]
	name = tensor_info.name
	return sess.graph.get_tensor_by_name(name)

with tf.Session(graph=tf.Graph()) as sess:
	meta_graph = tf.saved_model.loader.load(sess, [tf.saved_model.tag_constants.SERVING], export_dir='./model')

	signature = meta_graph.signature_def[tf.saved_model.signature_constants.DEFAULT_SERVING_SIGNATURE_DEF_KEY]
	images = get_tensor_from_tensor_info(sess, signature.inputs['images'])
	lengths = get_tensor_from_tensor_info(sess, signature.inputs['lengths'])
	widths = get_tensor_from_tensor_info(sess, signature.inputs['widths'])
	areas = get_tensor_from_tensor_info(sess, signature.inputs['areas'])
	predicts = get_tensor_from_tensor_info(sess, signature.outputs['predicts'])
	accuracies = get_tensor_from_tensor_info(sess, signature.outputs['accuracies'])

	batch = get_input_pipeline(4, 'validation', 72, 24, 1, root='./dataset')
	coord = tf.train.Coordinator()
	threads = tf.train.start_queue_runners(sess=sess, coord=coord)

	try:
		b = sess.run(batch)
		print(sess.run([predicts, accuracies], feed_dict={images:b[0], lengths:b[2], widths:b[3], areas:b[4]}))
	finally:
		coord.request_stop()
		coord.join(threads)

	#summary_op = tf.summary.merge_all()
	#summary_writer = tf.summary.FileWriter('./test_summary', sess.graph)


