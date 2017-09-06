from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import tensorflow as tf
import tensorflow.contrib.slim as slim
import numpy as np

CLASSES = 9

def spp_layer(x, levels, name='SPP_Layer'):
	shape = x.get_shape().as_list()
	with tf.variable_scope(name):
		pool_outputs = []
		for l in levels:
			size = [1, np.ceil(shape[1] * 1. / l).astype(np.int32), np.ceil(shape[2] * 1. / l).astype(np.int32), 1]
			pool = tf.nn.max_pool(x, ksize=size, strides=size, padding='SAME')
			#pool_outputs.append(tf.reshape(pool, [shape[0], -1]))
			pool_outputs.append(slim.flatten(pool))
		spp_pool = tf.concat(pool_outputs, 1)
	return spp_pool

def inference(images, lengths, widths, areas, keep_prob, is_training):
	with slim.arg_scope([slim.conv2d, slim.fully_connected],
											weights_initializer=tf.truncated_normal_initializer(0.0, 0.01)):
		with slim.arg_scope([slim.conv2d], normalizer_fn=slim.batch_norm):
			with slim.arg_scope([slim.batch_norm], decay=0.9, updates_collections=None, is_training=is_training):

				net = slim.conv2d(images, 8, [7, 7], scope='conv1')
				net = slim.max_pool2d(net, [2, 2], scope='pool1')
				net = slim.conv2d(net, 16, [7, 7], scope='conv2')
				net = slim.max_pool2d(net, [2, 2], scope='pool2')
			
				net = spp_layer(net, [6, 3, 2, 1])
				with tf.name_scope('concat_values'):
					widths = tf.reshape(widths, [-1, 1])
					lengths = tf.reshape(lengths, [-1, 1])
					areas = tf.reshape(areas, [-1, 1])
					net = tf.concat([lengths, widths, areas, net], 1)
			
				#--For Tensorboard
				conv_vars = tf.get_collection(tf.GraphKeys.MODEL_VARIABLES, 'conv')
				for cv in conv_vars:
					tf.summary.histogram(cv.name, cv)
				tf.summary.histogram('feature', net)
				#--
			
				net = slim.fully_connected(net, 512, scope='fc1')
				net = slim.dropout(net, keep_prob=keep_prob, scope='dropout1')
				net = slim.fully_connected(net, 256, scope='fc2')
				net = slim.dropout(net, keep_prob=keep_prob, scope='dropout2')
				net = slim.fully_connected(net, CLASSES, activation_fn=None, normalizer_fn=None, scope='output')
	return net

def loss(logits, labels):
	loss = tf.losses.sparse_softmax_cross_entropy(labels, logits)
	return tf.losses.get_total_loss()

def train(loss, learning_rate):
	tf.summary.scalar('total_loss', loss)
	step = tf.Variable(0, trainable=False)
	
	train_step = tf.train.AdamOptimizer(learning_rate).minimize(loss, global_step=step)
	return train_step

def evaluation(logits, labels):
	corrects = tf.nn.in_top_k(logits, labels, 1)
	accuracy = tf.reduce_mean(tf.cast(corrects, tf.float32))
	tf.summary.scalar('train_accuracy', accuracy)
	return accuracy

