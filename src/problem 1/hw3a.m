close all;
clear all;
img = imread('Boats.gif');
img = im2double(img);
originalimg = img;

[iw ih] = size(img);

scrsz = get(0,'ScreenSize');
qwsize = 256;
qlsize = 256;
scrnw = scrsz(4);

%quadrant=  dist-from-left   dist-from-bot w h
Q1      =   [0            scrnw      512 512];
Q2      =   [1*qwsize     scrnw      512 512];
Q3      =   [2*qwsize     scrnw      512 512];
Q4      =   [3*qwsize     scrnw      512 512];

Q5      =   [0            0      512 512];
Q6      =   [1*qwsize     0      512 512];
Q7      =   [2*qwsize     0      512 512];
Q8      =   [3*qwsize     0      512 512];



filter =    [
            0   0   -1  -1  -1  0   0;   ...
            0   -2  -3  -3  -3  -2  0;  ...
            -1  -3  5   5   5   -3  -1;  ...
            -1  -3  5   16  5   -3  -1;  ...
            -1  -3  5   5   5   -3  -1;  ...
            0   -2  -3  -3  -3  -2  0;  ...
            0   0   -1  -1  -1  0   0   ...
            ];
figOriginalImage = figure('Name','ORIGINAL IMAGE','Position',Q1);
figDogImage = figure('Name','A. DoG IMAGE','Position',Q2);
        

%result_a = maskapply(img, filter); %find DoG image
result_a = conv2(img,filter);

figure(figOriginalImage);
imshow(originalimg);

figure(figDogImage);
imshow(result_a);



