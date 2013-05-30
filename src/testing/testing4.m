close all;
clear all;

logmask = [0 0 1 0 0;
           0 1 2 1 0;
           1 2 -16 2 1;
           0 1 2 1 0;
           0 0 1 0 0];

img = imread('Boats0.gif');
img = im2double(img);
%img = conv2(img,logmask);  
%img = imcomplement(img);

check = bwlabel(img);

%imshow(img);
%imshow(check);

img = divideRanges(img,300);

showSplitImages([],0,25,[],img);