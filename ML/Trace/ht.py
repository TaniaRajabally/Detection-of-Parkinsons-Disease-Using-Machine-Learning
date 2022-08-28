import numpy as np
import cv2 

img=cv2.imread('Tracing Data\Old Data\HealthySpiral\HealthySpiral\sp1-H1.jpg')
cv2.imshow('x',img)
cv2.waitKey(0)
ht = cv2.blur(img,(5,5))
cv2.imshow('x',ht)
cv2.waitKey(0)
ht = cv2.medianBlur(ht,5)
ht[np.where((ht <= [100,100,100]).all(axis = 2)) ] = [255,255,255]
cv2.imshow('x',ht)
cv2.waitKey(0)
for i in range(ht.shape[0]):
    for j in range(ht.shape[1]):
        if(abs(ht[i][j][0]-ht[i][j][1])<40 and abs(ht[i][j][0]-ht[i][j][2])<40 and abs(ht[i][j][1]-ht[i][j][2])<40):
            ht[i][j]=[255,255,255] 

cv2.imshow('xox',ht)
cv2.waitKey(0)