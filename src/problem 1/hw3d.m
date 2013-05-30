close all;
clear all;
hw3c;

logmask = [0 0 1 0 0;
           0 1 2 1 0;
           1 2 -16 2 1;
           0 1 2 1 0;
           0 0 1 0 0];

img = imread('Boats.gif');
originalimg = img;
img = im2double(img);

result_d = conv2(img,logmask);

figPartD = figure('Name','D. Log Mask','Position',Q6);
figure(figPartD);
result_d = imcomplement(result_d);
imshow(result_d);
