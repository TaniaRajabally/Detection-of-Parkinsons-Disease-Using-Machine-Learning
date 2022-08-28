import numpy as np
import cv2 

img=cv2.imread('Tracing Data\Old Data\HealthySpiral\HealthySpiral\sp1-H1.jpg')
cv2.imshow('x',img)
cv2.waitKey(0)

et = cv2.blur(img,(5,5))
cv2.imshow('x',et)
cv2.waitKey(0)

et[np.where((et <= [100,100,100]).all(axis = 2)) ] = [0]
et[np.where((et >= [100,100,100]).any(axis = 2))] = [255]
cv2.imshow('xox',et)
cv2.waitKey(0)
et[et==255]=100
et[et==0]=255
et[et==100]=0
cv2.imshow('xox',et)
cv2.waitKey(0)


et = cv2.erode(et, None, iterations=1)
et = cv2.dilate(et, None, iterations=2)
cv2.imshow('x',et)
cv2.waitKey(0)
et = cv2.blur(et,(5,5))
cv2.imshow('x',et)
cv2.waitKey(0)


