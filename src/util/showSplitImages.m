function [  ] = showSplitImages(COLOR, invert, imagesAllowedPerRow, labels, varargin )
%SHOWSPLITIMAGES Combine many Images into one, then display it in a figure
%{
Written by Gagandip Singh, gagandip@buffalo.edu, 2012. 
Free for anyone to use or modify.

version: 0.1
todo:   Make the function still work if no labels argument is provided.
        currently user must at *minimum* include an empty array.
        Allow modification of label position, color, size, etc.

showSplitImages takes some images, along with labels and combines them
    into one big images, then showing it in a figure. 

arg1: 1 to invert the result, 0 otherwise
arg2: string matrix of labels for each image, currently you must label each
    image. example ['image1';'image2';'image3'] NOTE: EACH STRING MUST BE
    OF SAME LENGTH
arg3: images you want to display per row, seperated by a comma
%}

warning('off','Images:initSize:adjustingMag')

if size(labels,1) == 0
    shouldAddText = 0;
else
    labelarray = cellstr(labels);
    shouldAddText = 1;
end

inputCount = size(varargin,2);

maxrow = 0;
maxcol = 0; 
maxdim = 0;

for i=1:inputCount
    [q w e] = size(varargin{i});
    if (q>maxrow); maxrow=q; end
    if (w>maxcol); maxcol=w; end
    if (e>maxdim); maxdim=e; end
end

%img = zeros(maxrow,maxcol,maxdim);

i=1;
j=1;
while j<=inputCount
    [a b c] = size(varargin{j});
    currentLayer = varargin{j};
    if shouldAddText
        currentLayer = addText(labelarray{i},currentLayer);
    end
    for dim=1:c
        img(1:a,1:b,i) = currentLayer(1:a,1:b,dim);
        i = i+1;
    end
    j = j+1;
end


inputImages = img;
numOfInputImg = size(img,3);

%%%% Combine all Separate Region Images into one big Image and display %%%%
%imagesAllowedPerRow = 4;
imagesDisplayedPerRow = 0;
result = [];
temp = [];

for cnt=1:numOfInputImg
    imgLayer = inputImages(:,:,cnt);
    %figure(i);
    %imshow(imcomplement(imgLayer));

    if imagesDisplayedPerRow == imagesAllowedPerRow 
        %too many images in this row(of result), move to next row
        result = [result;temp];
        temp = [];
        imagesDisplayedPerRow = 0;
    end
    
    temp = [temp, imgLayer];
    imagesDisplayedPerRow = imagesDisplayedPerRow + 1;
    
    %[a b c] = size(result);
    %[d e f] = size(temp);
end

if imagesDisplayedPerRow == imagesAllowedPerRow 
    %too many images in this row(of result), move to next row
    result = [result;temp];
    temp = [];
    imagesDisplayedPerRow = 0;
else
    [a b c] = size(temp);
    zzz = zeros(maxrow,size(result,2));
    zzz(1:a,1:b) = temp(1:a,1:b);
    result = [result;zzz];
end

figure('Name','compiled');
if (invert==1)
    imshow(imcomplement(result),colormap(COLOR));
else
    imshow((result),colormap(COLOR));
end
clear all;
%%%% Combine all Separate Region Images into one big Image and display %%%%

end


function [textOnLayer] = addText(text,layer)
    htxtins = vision.TextInserter(text);
    htxtins.Color = [0, 0, 0]; % [red, green, blue]
    htxtins.FontSize = 20;
    htxtins.Location = [1 1]; % [x y]
    textOnLayer = step(htxtins, layer);
end

