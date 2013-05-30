function [result1 result2] = testing3 (img )
    close all;
    clearvars -except img;
    %img = imread(input);
    %img = im2double(img);
    %img = mat2gray(img);
    %img = img(:,:,1);


    quadrant = setUpQuadrants(2,2,8,100,300,1000,1000);

    %bp = Brightest Pixel
    [bpRowLoc bpColLoc bpDimLoc] = findLocationOfMax(img);

    %bpRowLoc = 150;
    %bpColLoc = 175;

    [irow icol] = size(img);
    regions = zeros(irow,icol);
    workmat = zeros(irow,icol);
    regionCount = 1;
    [rrow rcol] = size(regions);

    % regions(row, col, regionCount) = 1;
    % temp = checkAll(img,row,col,workmat,THRES);
    % regions(:,:,regionCount) = temp(:,:,1); 
    % regionCount = regionCount+1;
    % clear temp;

    %vpc = 1;
    %visualProgression = zeros(size(regions,1),size(regions,2),100);


    fprintf('...........\n');

    THRES = .1;
    totRegionCnt=1;

    regions(1,1) = img(1,1);
    %regions(:,:,totRegionCnt) = mergeLayers(regions, checkAll2(img,1,1,regions,THRES));
    
    [regions endedAtRow endedAtCol] = checkAll2(img,1,1,regions,THRES);

    %[regions endedAtRow endedAtCol] = checkAll2(img,endedAtRow,endedAtCol,regions,THRES);
    


    clearvars -except img regions quadrant visualProgression totRegionCnt;
    %showSplitImages(0,4,[],regions);
    figure('Name','Gagan','Position',[2100 578 900 900]);
    imshow(regions(:,:,1));
    result1 = regions;
    result2 = totRegionCnt;
    % result2 = visualProgression;
end

function [bool] = matchingCriteria(x,y,thres)
    if abs(x-y) < thres
        bool = 1;
    else
        bool = 0;
    end
end
function [result] = mergeLayers(img1,img2)
%return a img, which combines all non zero values of img1 & 2
%fprintf('Merge Call %d\n',mergecount);
[a b c] = size(img1);
[d e f] = size(img2);
if size(img1) ~= size(img2)
    fprintf('Error in mergeLayers: can only merge like dimensions.\n');
else
    result = zeros(a,b);
    for i=1:a
        for j=1:b
            if img1(i,j) ~= 0
                result(i,j) = img1(i,j);
            elseif img2(i,j) ~= 0
                result(i,j) = img2(i,j);
            end
        end
    end            
end   
end
function [result] = checkAll(img,bpRowLoc,bpColLoc,regions,THRES)
    regions = checkAbove(img,bpRowLoc,bpColLoc,regions,THRES);
    regions = checkBelow(img,bpRowLoc,bpColLoc,regions,THRES);
    regions = checkLeft(img,bpRowLoc,bpColLoc,regions,THRES);
    regions = checkRight(img,bpRowLoc,bpColLoc,regions,THRES);
    %regions = checkNW(img,bpRowLoc,bpColLoc,regions,THRES);
    %regions = checkSW(img,bpRowLoc,bpColLoc,regions,THRES);
    %regions = checkNE(img,bpRowLoc,bpColLoc,regions,THRES);
    %regions = checkSE(img,bpRowLoc,bpColLoc,regions,THRES);
    
    [irow icol] = size(img);
    
    if img(bpRowLoc,bpColLoc)
    end
    result=regions;
end
function [result] = checkSE (img,bpRowLoc,bpColLoc,regions,THRES) 
[irow icol] = size(img);
%check all pixels diagionally SE
checkRowLoc=bpRowLoc;
checkColLoc = bpColLoc;
while checkRowLoc < irow-1 && checkColLoc < icol-1
    current = img(bpRowLoc,checkColLoc);
    diagSE = img(bpRowLoc+1,checkColLoc+1);
    if matchingCriteria(current,diagSE,THRES)
        regions(checkRowLoc,checkColLoc) = img(checkRowLoc,checkColLoc);
    else
        %did not match criteria
        break;
    end
    checkRowLoc = checkRowLoc+1;
    checkColLoc = checkColLoc+1;
end
result=regions;
end
function [result] = checkNE (img,bpRowLoc,bpColLoc,regions,THRES) 
[irow icol] = size(img);
%check all pixels diagionally NE
checkRowLoc=bpRowLoc;
checkColLoc = bpColLoc;
while checkRowLoc > 1 && checkColLoc < icol-1
    current = img(bpRowLoc,checkColLoc);
    diagSE = img(bpRowLoc-1,checkColLoc+1);
    if matchingCriteria(current,diagSE,THRES)
        regions(checkRowLoc,checkColLoc) = img(checkRowLoc,checkColLoc);
    else
        %did not match criteria
        break;
    end
    checkRowLoc = checkRowLoc-1;
    checkColLoc = checkColLoc+1;
end
result=regions;
end
function [result] = checkSW (img,bpRowLoc,bpColLoc,regions,THRES) 
[irow icol] = size(img);
%check all pixels diagionally South-West
checkRowLoc=bpRowLoc;
checkColLoc = bpColLoc;
while checkRowLoc < irow-1 && checkColLoc > 1
    current = img(bpRowLoc,checkColLoc);
    diagSW = img(bpRowLoc+1,checkColLoc-1);
    if matchingCriteria(current,diagSW,THRES)
        regions(checkRowLoc,checkColLoc) = img(checkRowLoc,checkColLoc);
    else
        %did not match criteria
        break;
    end
    checkRowLoc = checkRowLoc+1;
    checkColLoc = checkColLoc-1;
end
result=regions;
end
function [result] = checkNW (img,bpRowLoc,bpColLoc,regions,THRES) 
[irow icol] = size(img);
%check all pixels diagionally North-West
checkRowLoc=bpRowLoc;
checkColLoc = bpColLoc;
while checkRowLoc > 1 && checkColLoc > 1
    current = img(bpRowLoc,checkColLoc);
    diagNW = img(bpRowLoc-1,checkColLoc-1);
    if matchingCriteria(current,diagNW,THRES)
        regions(checkRowLoc,checkColLoc) = img(checkRowLoc,checkColLoc);
    else
        %did not match criteria
        break;
    end
    checkRowLoc = checkRowLoc-1;
    checkColLoc = checkColLoc-1;
end
result=regions;
end
function [result] = checkRight (img,bpRowLoc,bpColLoc,regions,THRES) 
    if bpColLoc+1 > size(img,2) || regions(bpRowLoc,bpColLoc+1) 
        %if location is out-of-bounds, or the pixel to the right is
        %non-zero...
        result = regions;
        return;
    else
        [irow icol] = size(img);
        %check all pixels to the right of the brightest pixel
        checkRowLoc = bpRowLoc;
        checkColLoc = bpColLoc;
        while checkColLoc < icol
            current = img(bpRowLoc,checkColLoc);
            right = img(bpRowLoc,checkColLoc+1);
            if matchingCriteria(current,right,THRES)
                regions(bpRowLoc,checkColLoc) = img(checkRowLoc,bpColLoc);
            else
                %did not match criteria
                break;
            end
            checkColLoc = checkColLoc+1;
        end
        result=regions;
    end
end
function [result] = checkLeft (img,bpRowLoc,bpColLoc,regions,THRES) 
    if bpColLoc-1<1 
        
        result = regions;
        return;
    elseif regions(bpRowLoc,bpColLoc-1)
                
        result = regions;
        return;
    else
        [irow icol] = size(img);
        %check all pixels to the left of the brightest pixel
        checkRowLoc = bpRowLoc;
        checkColLoc = bpColLoc;
        while checkColLoc > 1
            current = img(bpRowLoc,checkColLoc);
            left = img(bpRowLoc,checkColLoc-1);
            if matchingCriteria(current,left,THRES)
                regions(bpRowLoc,checkColLoc) = img(checkRowLoc,bpColLoc);
            else
                %did not match criteria
                break;
            end
            checkColLoc = checkColLoc-1;
        end
        result=regions;
    end
end
function [result] = checkBelow (img,bpRowLoc,bpColLoc,regions,THRES) 
    if bpRowLoc+1>size(img,1) || regions(bpRowLoc+1,bpColLoc)
        result = regions;
        return;
    else
        [irow icol] = size(img);
        %check all pixels below the brightest pixel
        checkRowLoc = bpRowLoc;
        checkColLoc = bpColLoc;
        while checkRowLoc < irow-1
            current = img(checkRowLoc,bpColLoc);
            below = img(checkRowLoc+1,bpColLoc);
            if matchingCriteria(current,below,THRES)
                regions(checkRowLoc,bpColLoc) = img(checkRowLoc,bpColLoc);
            else
                %did not match criteria
                break;
            end
            checkRowLoc = checkRowLoc+1;
        end
        result=regions;
    end
end
function [result] = checkAbove (img,bpRowLoc,bpColLoc,regions,THRES)
    
    if  bpRowLoc-1<1 || regions(bpRowLoc-1,bpColLoc)
        result = regions;
        return;
    else
        [irow icol] = size(img);
        %check all pixels above the brightest pixel
        checkRowLoc=bpRowLoc; %to start immedietely to the top of bp
        checkColLoc=bpColLoc;
        while checkRowLoc > 1
            %check all pixels above bp until region-matching-criteria not met
            current = img(checkRowLoc,bpColLoc);
            above = img(checkRowLoc-1,bpColLoc);
            if matchingCriteria(current,above,THRES)
                regions(checkRowLoc,bpColLoc) = img(checkRowLoc,bpColLoc);
            else
                %did not match criteria
                break;
            end
            checkRowLoc = checkRowLoc-1;
        end
        result=regions;
    end
end

function [result endedAtRow endedAtCol] = checkAll2(img,rowLoc,colLoc,regions,THRES)
    [foundregions endedAtRow endedAtCol] = checkNeighbor('right',img,rowLoc,colLoc,regions,THRES);
    [foundregions endedAtRow endedAtCol] = checkNeighbor('down',img,endedAtRow,endedAtCol,foundregions,THRES);
    [foundregions endedAtRow endedAtCol] = checkNeighbor('left',img,endedAtRow,endedAtCol,foundregions,THRES);
    [foundregions endedAtRow endedAtCol] = checkNeighbor('up',img,endedAtRow,endedAtCol,foundregions,THRES);
    
    %{
    if foundregions == regions
        %no more pixels are in this region
        result = foundregions;
    else
        foundregions = checkAll2(img,rowLoc+1,colLoc,foundregions,THRES);
        rowLoc = 1; colLoc = 1;
        foundregions = checkAll2(img,rowLoc+1,colLoc+1,foundregions,THRES);
        result = foundregions;
    end
    %}
    result = foundregions;
end

function [result, result2, result3] = checkNeighbor(direction,img,rowLoc,colLoc,region,THRES)
    
%     if size(find(region),1) >5
%         result = region;
%         result2 = rowLoc;
%         result3 = colLoc;
%         return;
%     end

    [imgrow imgcol] = size(img);
    result2 = rowLoc;
    result3 = colLoc;
    
    switch direction
        %of row or col OOB then return the input region
        case 'up'
            if rowLoc == 1 
                result = region;
                return;
            else
                nextrow = rowLoc-1;
                nextcol = colLoc;
            end
        case 'right'
            if colLoc >= imgcol
                result = region;
                return;
            else
                nextrow = rowLoc;
                nextcol = colLoc+1;
            end
        case 'down'
            if rowLoc >= imgrow
                result = region;
                return;
            else
                nextrow = rowLoc+1;
                nextcol = colLoc;
            end
        case 'left'
            if colLoc <= 1
                result = region;
                return;
            else
                nextrow = rowLoc;
                nextcol = colLoc-1;
            end
    end
    
    current = img(rowLoc,colLoc);
    next = img(nextrow,nextcol);
    if matchingCriteria(current,next,THRES) 
        %if current and next match criteria, put 
        %the current pixel in the region layer
        region(nextrow,nextcol) = next;
        %{
        if strcmp(direction,'right')
            region = checkNeighbor('up',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('right',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('down',img,nextrow,nextcol,region,THRES);
        elseif strcmp(direction,'down')
            region = checkNeighbor('left',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('down',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('right',img,nextrow,nextcol,region,THRES);
        elseif strcmp(direction,'left')
            region = checkNeighbor('left',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('up',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('down',img,nextrow,nextcol,region,THRES);         
        elseif strcmp(direction,'up')
            region = checkNeighbor('up',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('left',img,nextrow,nextcol,region,THRES);
            region = checkNeighbor('right',img,nextrow,nextcol,region,THRES);            
        end
        %}
        
    else
        %did not match criteria
        result = region;
        result2 = imgrow;
        result3 = imgcol;
    end
            result = region;
        result2 = imgrow;
        result3 = imgcol;
end




