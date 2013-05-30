%find strong edges that have 1st deriv support...
%img is our zero-cross'd image

%{
close all;

hw3b;

figStrongEdge = figure('Name','STRONG EDGES','Position',Q4);
figSobelEdge = figure('Name','SOBEL EDGES','Position',Q5);

strongEdgesImage = findFirstDeriv(img); %find strong edges

figure(figStrongEdge);
imshow(strongEdgesImage);

sobel = edge(img,'sobel');
figure(figSobelEdge);
imshow(sobel);

%}

clear all;
close all;

hw3b;

sobelHorizontalFilter = [-1 0 1;
                        -2 0 2;
                        -1 0 1];
              
sobelVerticalFilter =   [-1 -2 -1;
                        0  0  0;
                        1  2  1];
              
           
sobelImgHorizontal = conv2(originalimg,sobelHorizontalFilter);
sobelImgVertical   = conv2(originalimg,sobelVerticalFilter);
%sobelImgHorizontal2 = maskapply(img,sobelHorizontalFilter);
%sobelImgVertical2   = maskapply(img,sobelVerticalFilter);

sobelImg = sqrt((sobelImgHorizontal.^2) + (sobelImgVertical.^2));

[sr sc] = size(sobelImg);
tsobel = zeros(sc,sr);


THRES = .8;

for i=1:sr
    for j=1:sc
        if sobelImg(i,j) > THRES
            tsobel(i,j) = sobelImg(i,j);
        end
    end
end

figStrongEdge = figure('Name','C. STRONG EDGES','Position',Q4);
figure(figStrongEdge);
imshow(imcomplement(tsobel),[]);


