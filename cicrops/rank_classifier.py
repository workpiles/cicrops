from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tensorflow as tf
import numpy as np
import cv2
from tfmodel.model import inference
from util import mount_image
import time

H = 72
W = 24
C = 1
MAX_LENGTH = 332
MAX_AREA = 14291
MAX_WIDTH = 83.0
RESTORE_PATH = './tfmodel/model'

def get_tensor_from_tensor_info(sess, tensor_info):
	#Instead of tf.saved_model.utils.get_tensor_from_tensor_info[TF r1.3]
	name = tensor_info.name
	return sess.graph.get_tensor_by_name(name)

class Predictions():
	def __init__(self):
		self._list_of_label = []
		self._list_of_accuracy = []

	def add(self, label, accuracy):
		self._list_of_label.append(label)
		self._list_of_accuracy.append(accuracy)

	def get(self, index):
		return self._list_of_label[index], self._list_of_accuracy[index]

	def get_top_labels(self):
		labels = []
		for top,_ in self._list_of_label:
			labels.append(top)
		return labels

	def get_all_labels(self):
		return self._list_of_label

	def get_all_accuraces(self):
		return self._list_of_accuracy


class RankClassifier():
	def __init__(self):
		#self._sess = tf.Session(graph=tf.Graph())
		sess = tf.Session()
		meta_graph = tf.saved_model.loader.load(sess, [tf.saved_model.tag_constants.SERVING], export_dir=RESTORE_PATH)

		signature = meta_graph.signature_def[tf.saved_model.signature_constants.DEFAULT_SERVING_SIGNATURE_DEF_KEY]
		self._images = get_tensor_from_tensor_info(sess, signature.inputs['images'])
		self._lengths = get_tensor_from_tensor_info(sess, signature.inputs['lengths'])
		self._widths = get_tensor_from_tensor_info(sess, signature.inputs['widths'])
		self._areas = get_tensor_from_tensor_info(sess, signature.inputs['areas'])
		self._predicts = get_tensor_from_tensor_info(sess, signature.outputs['predicts'])
		self._accuracies = get_tensor_from_tensor_info(sess, signature.outputs['accuracies'])
		self._sess = sess

	def predict(self, images, areas, h_ratio=0, w_ratio=0):
		h_ratio = round(h_ratio, 2)
		w_ratio = round(w_ratio, 2)
		paste_images = []
		paste_areas = []
		lengths = []
		widths = []
		for i,a in zip(images, areas):
			h,w,_ = i.shape
			size = (int(w+w*w_ratio), int(h+h*h_ratio))
			i = cv2.resize(i, size)
			i = mount_image(i)
			i = cv2.resize(i, (W, H))
			i = cv2.cvtColor(i, cv2.COLOR_BGR2GRAY)
			paste_images.append(np.reshape(np.array(i, dtype=np.float32)/255.0, (H, W, C)))
			h /= MAX_LENGTH
			lengths.append(h)
			a = (a*(1+h_ratio)*(1+w_ratio))/MAX_AREA
			paste_areas.append(a)
			widths.append(a/h)

		feed_dict = {self._images: paste_images,
								 self._lengths: lengths,
								 self._widths: widths,
								 self._areas: paste_areas}
		predicts, accuracies = self._sess.run([self._predicts, self._accuracies], feed_dict=feed_dict)
		
		result = Predictions()
		for i in xrange(len(predicts)):
			label = predicts[i]
			accuracy = accuracies[i][label]
			result.add(label, accuracy)

		return result
		
#if __name__=='__main__':
#	cls = RankClassifier()
#
#	images = [cv2.imread("test/2S_01448.jpg"),
#					  cv2.imread("test/L_01184.jpg")]
#	areas = [9000.0, 8700.0]
#
#	for i in xrange(1):
#		start = time.time()
#		predict, accuracy = cls.predict(images, areas)
#		print(predict, accuracy,"Eval:%g"%(time.time() - start))


