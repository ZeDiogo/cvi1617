import cv2
import sys

file=sys.argv[1]
print(cv2.__version__)
vidcap = cv2.VideoCapture(file)
success,image = vidcap.read()
count = 1
success = True
while success:
	success,image = vidcap.read()
	print 'Reading frame', count, ': ', success
	cv2.imwrite("frame%05d.jpg" % count, image)
	count += 1