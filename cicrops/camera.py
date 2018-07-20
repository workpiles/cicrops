from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import cv2
import numpy as np
import cPickle as pickle

TEMPLATE_SIZE = 25
MOVING_THRESHOLD = 3
OFFSET = 10

CAP_WIDTH  = 640
CAP_HEIGHT = 480

class CameraResult(object):
	def __init__(self, src, moving, caps, areas, centers, rects):
		self.src = src
		self.moving = moving
		self.images = caps
		self.areas = areas
		self.centers = centers
		self.rects = rects

class Camera(object):
	def __init__(self, disp_size, dev=0):
		cam = cv2.VideoCapture(dev)
		cam.set(cv2.cv.CV_CAP_PROP_FRAME_WIDTH, CAP_WIDTH)
		cam.set(cv2.cv.CV_CAP_PROP_FRAME_HEIGHT, CAP_HEIGHT)
		self._cam = cam
		self._mask = None
		self._frame = None
		self._matrix = None
		self._capture_size = None
		self._num_of_nochange = 0
		self._centers_buff = []
		self._disp_size = disp_size

	def get_capture_size(self):
		return self._capture_size

	def is_calibrated(self):
		return self._matrix is not None and self._capture_size[0] > 500 and self._capture_size[1] > 300

	def calibration(self):
		_, frame = self._cam.read()
		frame = cv2.flip(frame, -1)

		tl = self._patternMatch(frame, "marker/marker_left_top.jpg")
		tr = self._patternMatch(frame, "marker/marker_right_top.jpg")
		bl = self._patternMatch(frame, "marker/marker_left_bottom.jpg")
		br = self._patternMatch(frame, "marker/marker_right_bottom.jpg")

		tl = tl
		tr = (tr[0] + TEMPLATE_SIZE, tr[1])
		bl = (bl[0], bl[1] + TEMPLATE_SIZE)
		br = (br[0] + TEMPLATE_SIZE, br[1] + TEMPLATE_SIZE)

		frame_width = ((tr[0] - tl[0]) + (br[0] - bl[0])) // 2
		frame_height = ((bl[1] - tl[1]) + (br[1] - tr[1])) // 2
		self._capture_size = (frame_width, frame_height)

		self._matrix = self._getPerspectiveTransform([tl, tr, br, bl], self._capture_size)
		#frame = cv2.warpPerspective(frame, self._matrix, self._capture_size)
		#cv2.imwrite("camera_log/calib_result.jpg", frame)
		with open('calib.pkl', mode='wb') as f:
			cali_param = {'capture_size': self._capture_size, 'matrix': self._matrix}
			pickle.dump(cali_param, f)

		#Convert to relative
		tl = (tl[0] / CAP_WIDTH, tl[1] / CAP_HEIGHT)
		tr = (tr[0] / CAP_WIDTH, tr[1] / CAP_HEIGHT)
		bl = (bl[0] / CAP_WIDTH, bl[1] / CAP_HEIGHT)
		br = (br[0] / CAP_WIDTH, br[1] / CAP_HEIGHT)
		return (tl, tr, bl, br)

	def restore_calibration(self):
		with open('calib.pkl', mode='rb') as f:
			param = pickle.load(f)
			self._capture_size = param['capture_size']
			self._matrix = param['matrix']

	def _patternMatch(self, image, pattern):
		template = cv2.imread(pattern, 0)
		template = cv2.resize(template, (TEMPLATE_SIZE, TEMPLATE_SIZE))
		gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
		_, gray = cv2.threshold(gray, 120, 255, cv2.THRESH_BINARY)
		cv2.imwrite("camera_log/ptnMatch.jpg", gray)
		res = cv2.matchTemplate(gray, template, cv2.TM_CCOEFF_NORMED)
		min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)
		#return max_loc if max_val > 0.5 else None
		return max_loc

	def _getPerspectiveTransform(self, src, size):
		src = np.float32(src)
		dst = np.float32([(0,0), (size[0],0), (size[0], size[1]), (0, size[1])])
		return cv2.getPerspectiveTransform(src, dst)

	def capture(self):
		assert self._matrix is not None
		_, frame = self._cam.read()
		frame = cv2.flip(frame, -1)
		frame = cv2.warpPerspective(frame, self._matrix, self._capture_size)

		mask = self._getMaskFromThreshold(frame)
		masked = cv2.bitwise_and(frame, frame, mask=mask)

		contours, areas = self._getContours(mask)

		objects = self._getContourImage(frame, contours)

		centers = []
		for c,_,_ in contours:
			centers.append((int(c[0]), int(c[1])))
		if self._is_moving(centers):
			self._num_of_nochange = 0
		else:
			self._num_of_nochange += 1

		rects = self._get_display_rects(contours)
		centers = self._get_display_centers(centers)
		result = CameraResult(frame, (self._num_of_nochange < MOVING_THRESHOLD),
														objects, areas, centers, rects)
		return result
	
	def _getContourImage(self, img, contours):
		images = []
		for center, size, angle in contours:
			matrix = cv2.getRotationMatrix2D(center, angle, 1.0)
			rotate = cv2.warpAffine(img, matrix, (img.shape[1], img.shape[0]), flags=cv2.INTER_CUBIC)
			crop = rotate[int(center[1] - size[1]/2):int(center[1] + size[1]/2),int(center[0] - size[0]/2):int(center[0] + size[0]/2),:]
			images.append(crop)
		return images

	def _getMaskFromThreshold(self, img):
		gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
		#_, mask = cv2.threshold(gray, 120, 255, cv2.THRESH_BINARY)
		_, mask = cv2.threshold(gray, 60, 255, cv2.THRESH_BINARY)
		mask = cv2.bitwise_not(mask)
		cv2.imwrite("camera_log/mask.jpg", mask)
		return mask
		
	def _getContours(self, mask):
		contours, hierarchy = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

		area_rects = []
		areas = []
		for i in xrange(len(contours)):
			area = cv2.contourArea(contours[i])
			if area < 2000:
				continue
			center, size, angle = cv2.minAreaRect(contours[i])
			if angle < -45:
				size = tuple(reversed(size))
				angle = angle + 90
			area_rects.append((center, size, angle))
			areas.append(area)
		return area_rects, areas

	def _get_display_rects(self, contours):
		cw,ch = self.get_capture_size()
		rects = []
		for cnt in contours:
			rect = []
			for p in cv2.cv.BoxPoints(cnt):
				rect.append((p[0] / cw) * self._disp_size[0])
				rect.append((1.0 - p[1] / ch) * self._disp_size[1])
			rects.append(rect)
		return rects

	def _get_display_centers(self, centers):
		cw,ch = self.get_capture_size()
		ret = []
		for pos in centers:
			x = int((pos[0] / cw) * self._disp_size[0])
			y = int((pos[1] / ch) * self._disp_size[1])
			ret.append((x,y))
		return ret
			
	def _is_moving(self, centers):
		ret = True 
		if len(self._centers_buff) == len(centers):
			ret = False
			for i in xrange(len(centers)):
				x1, y1 = self._centers_buff[i]
				x2, y2 = centers[i]
				if abs(x1 - x2) > OFFSET or abs(y1 - y2) > OFFSET :
					ret = True
					break
		self._centers_buff = centers
		return ret

	def release(self):
		self._cam.release()

if __name__=='__main__':
	cam = TableCamera((1920, 1080))
	cam.restore_calibration()

	while 1:
		result = cam.capture()
		cv2.imshow("test", result.src)

		key = cv2.waitKey(3) & 0xff
		if key==ord('q'):
			break;


