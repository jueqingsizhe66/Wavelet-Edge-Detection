clear all;
close all;
hw3a;
%result_a is DoG

%result_a = mat2gray(result_a);
result_b = findzerocross(result_a); %finds zero-crossings in the DoG of
                                    %the original image
                                    
figZeroCross = figure('Name','B. ZERO CROSSING','Position',Q3);
figure(figZeroCross);
imshow(imcomplement(result_b));