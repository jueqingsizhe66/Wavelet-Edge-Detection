clear all;
close all;
tic;
img = imread('BoatsM.gif');
img = im2double(img);
img = mat2gray(img);
img = img(:,:,1); %%in case of color image, choose red layer
origimg = img;
[irow icol] = size(img);


quadrant = setUpQuadrants(2,1,8,100,300,irow,icol);

%{
Algorithm 6.17: Region Merging
1. Define some starting method to segment the image 
   into many small regions satisfying condition (6.30)

2. Define a criterion for merging two adjacent regions

3. Merge all adjacent regions satisfying the merging
   critereon. If no two regions can be merged maintaining   
   condition (6.30) stop.
%}

%{
My Solution
1.  divide the img so that each division only contains
    pixels that fall in 1/divisor range
    
    ex: for divisor = 4
    r1 = first 25% of values... (ie: 0.00-->0.25)
    r2 = 2nd 25% if vales..     (ie: 0.26-->0.50)
    r3                          (ie: 0.51-->0.75)
    r4                          (ie: 0.76-->1.00)

2.  if R1&R2 are adjacent && if std(mean(R1),mean(R2)) < some
    THRESHOLD 
    should be merged

%}

                    %divide 'img' up into 'imgDivided'
%-------------------------------------------------------------------------
%{
    -   this is important so that we can get similar pixels seperated. eg:
        there may be pixels that are not connected via adjacency, but may
        still be part of the same region in an image via similar grayscale
        values. Each layer in imgDivided will be a rough estimate of our
        regions. From there we can try to find adjacency and find true
        regions.
    -   imgDivided is a 3d matrix, where each layer contains pixels that 
        fall in one of 1/DIVIDER ranges.
%}

DIVIDER = 4;
imgDivided = divideRanges(img,DIVIDER); 
%showSplitImages([],1,8,[],imgDivided); %display  each of the divisions

%-------------------------------------------------------------------------


                    %take layers of 'imgDivided' and...
%-------------------------------------------------------------------------
%{
    -   FOR EACH DIVISION
            divisionLAB = bwlabel(division)   
            while there exists non-zero pixels in divisionLab
                    for all pixels in divisionLab
                        if pixel == 1
                            add it to the same spot in a 'result' matrix
                            make pixel==0
                        endif
                    endfor
                    bwlabel again on whats left, which is a bwlabel'd
                    matrix with all the 1's replaced with 0's.
                    --esentially we have extracted one region, defined as
                    all pixels that are touching each other. using bwlabel
                    again will cause the 2nd region to be all ==1, making
                    our for-loop reusable.
            end while
        END FOR EACH DIVISION
        
    -   we now have a 3dmatrix, with a ton of layers, and each layer is
        comprised of pixels that not only are similar in grayscale
        value(becuase of 'divideRanges' function), but also only adjacent,
        because of what we just finished.
%}

divisionLAB = zeros(irow,icol,DIVIDER);
result = zeros(irow,icol,DIVIDER^2); %DIVIDER/2 does not mean anything, 
                                     %it is just a rough estimate of how 
                                     %much space may may needed.
regionCount = 0;

for currentDivision=1:DIVIDER           % for each division
    fprintf('Scanning division %2d/%2d. ',currentDivision,DIVIDER);
    cDivisionL = bwlabel(imgDivided(:,:,currentDivision));
    while find(cDivisionL==1)           % loop while label '1' still exists
        regionCount = regionCount + 1;            
        for cPixRow=1:irow              % for each pixel
            for cPixCol=1:icol          % in cDivisionL
                if cDivisionL(cPixRow,cPixCol) == 1
                    result(cPixRow,cPixCol,regionCount) = img(cPixRow,cPixCol);
                    cDivisionL(cPixRow,cPixCol) = 0;
                end
            end
        end                             % end for each pixel
                                        % in cDivisionL
        cDivisionL = bwlabel(cDivisionL);
    end                                 % loop until all pixels in cDivisionL are 0
    fprintf('Found %d regions.\n',regionCount);
end


%-------------------------------------------------------------------------

fprintf('Done. Total Regions Found: %d.\n',regionCount);

%%showSplitImages([],0,10,[],result(:,:,:));

CLEAN_UP_THRES = 10;
fprintf('\nConsolidate smaller regions based on color & distance from each other...\n');
resultCleaned = cleanUpRegions(result,CLEAN_UP_THRES);
close all;
resultCleaned = cleanUpRegions(resultCleaned,CLEAN_UP_THRES); %2nd pass...
close all;
[resrow rescol resdim] = size(result);
fprintf('Cleaned up Regions. Region count is now %d, %d less than %d\n\n',resdim,regionCount-size(result,3), regionCount);

showSplitImages([],0,15,[],resultCleaned(:,:,:));



result2 = zeros(irow,icol);
modifier = floor(255/resdim); %%255 color ranges, divide that by the regions
                                %%gives you how much difference in color value
                                %%can be in between each region

%{                                
%%re-color each region to give a pretty one-layer output
f1 = figure;
for i=1:size(resultCleaned,3)
    fprintf('re-coloring layer %d\n',i);
    for j=1:irow
        for k=1:icol
            if resultCleaned(j,k,i) ~= 0
                result2(j,k) = resultCleaned(j,k,i);
                result2(j,k) = i*modifier; %%make each region one color value
                figure(f1);
                imshow(result2);
            end
        end
    end
end
fprintf('Done Re-Coloring.\n');

showSplitImages('jet',0,10,[],result2);
%}

toc;





