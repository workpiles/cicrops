from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import numpy as np
import cv2

def mount_image(image):
	canvas = np.zeros([340, 100, 3], dtype=np.uint8)
	h,w,c = image.shape
	h = 340 if h > 340 else h
	w = 100 if w > 100 else w
	canvas[0:h,0:w,0:3] = image[0:h,0:w,0:3]
	return canvas
