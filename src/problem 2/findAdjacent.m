function [ result regionCount ] = findAdjacent( imgSegment )
%FINDADJACENT Summary of this function goes here
%   imgSegment is a divison of an overall image, found via divideRanges

    cDivisionL = bwlabel(imgSegment);
    [irow icol] = size(imgSegment);
    result = zeros(irow,icol,max(max(cDivisionL)));     %dim size=max # in cDivisionL
                                                        %ie: how many
                                                        %regions
    regionCount = 0;                                                    
    while find(cDivisionL==1)           % loop while label '1' still exists
        regionCount = regionCount + 1;            
        for cPixRow=1:irow                              % for all pixels
            for cPixCol=1:icol                          % in cDivisionL
                if cDivisionL(cPixRow,cPixCol) == 1     % find all adjacent
                    result(cPixRow,cPixCol,regionCount) = imgSegment(cPixRow,cPixCol);
                    åcDivisionL(cPixRow,cPixCol) = 0;
                end
            end
        end                             % end for each pixel
                                        % in cDivisionL
        cDivisionL = bwlabel(cDivisionL);
    end                                 % loop until all pixels in cDivisionL are 0
    
    
end

