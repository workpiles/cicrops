from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
import tensorflow as tf
import cv2

MIN_LENGTH = 122
MAX_LENGTH = 332
MIN_AREA = 4761
MAX_AREA = 14291
MIN_WIDTH = 22.0
MAX_WIDTH = 83.0

def read_from_tfrecord(filename_queue):
	reader = tf.TFRecordReader()
	key, serialized_example = reader.read(filename_queue)

	features = tf.parse_single_example(
		serialized_example,
		features = {
			'image/encoded': tf.FixedLenFeature([], tf.string),
			'image/class/label': tf.FixedLenFeature([], tf.int64),
			'image/height': tf.FixedLenFeature([], tf.int64),
			'mask/area': tf.FixedLenFeature([], tf.int64)
		})

	image = tf.image.decode_jpeg(features['image/encoded'], channels=3)
	label = tf.cast(features['image/class/label'], tf.int32)
	length = tf.cast(features['image/height'], tf.float32)
	width = tf.cast((features['mask/area'] / features['image/height']), tf.float32)
	area = tf.cast(features['mask/area'], tf.float32)
	return image, label, length, width, area

def get_input_pipeline(batch_size, splits, h, w, c, root) :
	if splits=='train':
		path_list = [root + "/dataset_train_0000"+str(n)+"-of-00007.tfrecord" for n in range(7)]
	else:
		path_list = [root + "/dataset_validation_0000"+str(n)+"-of-00002.tfrecord" for n in range(2)]
	
	filename_queue = tf.train.string_input_producer(path_list, num_epochs=None, shuffle=False)

	image, label, length, width, area = read_from_tfrecord(filename_queue)

	#preproccesing
	image = tf.image.resize_images(image, [h, w])
	if c==1:
		image = tf.image.rgb_to_grayscale(image)
	if splits=='train':
		image = tf.image.random_brightness(image, max_delta=0.2)

	image = tf.cast(image, tf.float32) / 255.0
	length /= MAX_LENGTH
	width /= MAX_WIDTH
	area /= MAX_AREA

	#batch
	num_examples_per_epoch_for_train = 7000
	min_fraction_of_examples_in_queue = 0.4
	min_queue_examples = int(num_examples_per_epoch_for_train * min_fraction_of_examples_in_queue)
	if splits=='train':
		images, labels, lengths, widths, areas = tf.train.shuffle_batch(
			[image, label, length, width, area],
			batch_size=batch_size,
			min_after_dequeue=min_queue_examples,
			capacity=min_queue_examples + 3 * batch_size)
	else:
		images, labels, lengths, widths, areas = tf.train.batch(
			[image, label, length, width, area],
			batch_size=batch_size)

	return images, labels, lengths, widths, areas

