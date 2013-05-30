clear all;
close all;

img = imread('feet.jpg');
img = im2double(img);
img = mat2gray(img);
img = img(:,:,1);
[i_row i_col] = size(img);

quadrant = setUpQuadrants(2,1,8,100,300,i_row,i_col);

%%

THRES = 1;
DIVIDER = 3;

%divide into regions by grayscale value
%if pixel value is in a range which is 
%1/DIVIDER long, insert into a layer of regionInfo2D
for x=1:i_row
    for y=1:i_col
%       if y+1>i_col
            %nothing...
%       else
        %r1 = (0.00-->0.25)
        %r2 = (0.26-->0.50)
        %r3 = (0.51-->0.75)
        %r4 = (0.76-->1.00)

        pixel  = img(x,y);
        minrange = 0.00;
        for numerator=1:DIVIDER
            maxrange = numerator/DIVIDER;
            if ( (pixel>=minrange) && (pixel<=maxrange) )   %Rn
                regionInfo2D(x,y,numerator) = pixel;
                break;
            end
            minrange = maxrange;
        end
    end
end 

%showSplitImages(1,4,[],regionInfo2D); %display the images split up via
                                       %grayscale ranges


%%

PIXELCOUNTTHRES = 30;
result3 = zeros(i_row,i_col);
for i=1:DIVIDER %for each range...

    regionInfo3D = region2Dto3D(regionInfo2D(:,:,i));

    %get the size info for regionInfo3D layer
    %('regionInfo3D' == (regionInfoLayer-->3d matrix))
    [r_row r_col r_dim] = size(regionInfo3D); 

    %{
    for each layer in regionInfo3D, determine how
    many pixels exist. If they are below a
    certain threshold, merge that layer with
    the one that comes after it. Check this 
    newly created layer with the one in front
    of that, if there are enough pixels in this
    new layer, compare next one with the one 
    after that.. loop until done.
    %}

    %clearvars -except QUANTTHRES regionInfo3D img;
    result2 = shouldMerge2(regionInfo3D, PIXELCOUNTTHRES);
    for j=1:(size(result2,3))
        result3(:,:,end+1) = result2(:,:,j);
    end
    %{
    FOR THE SPECIFIC RANGE (in regionInfo3d)
    display all the regions generated by my algo 
    (if #of pixels is < PIXELCOUNTTHRES, merge) 
    %showSplitImages(0,4,[],result2);
    %}
    
    result4 = shouldMerge2(result3,PIXELCOUNTTHRES);
end






