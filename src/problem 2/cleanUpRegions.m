function [ regions ] = cleanUpRegions( regions,threshold )

                    %take layers of 'result' and clean up
%-------------------------------------------------------------------------
%{
    -   result contains our regions (on the 3rd dimension), but the 
        problem is that many of these regions are only a pixel or 
        two in size
    -   we should locate these small-region-layers inside of 'regions'
        and combine them in a region-layer that is close by, even though
        the two regions are not exactly adjacent.
    -   the idea is that we already know that every layer inside of
        'regions' is similar in grayscale value (since this function
        is being called after extracting a region from a division) so
        small-region-layers and the larger-regions that are closest
        we would think intuitively, is actually the same region, even
        though they are not 100% adjacent.

    *   input: 3d-matrix where each layer is a region
        output: a 3d-matrix where the dimension is (hopefully) smaller than
        the dimension of the input, due to combining small-regions with
        closer, larger regions.
%}

%%
%%create a matrix to hold


%%
cDim = 1;
regionsRemoved = 0;
[rrow rcol rDim] = size(regions);
totPixels = rrow * rcol;
counter = 0;

%find the quantity of non-zero pixels for each layer, 
%and store that info seperately so computing takes less time.

%rDim rows by 2 col storing non-zero pixel info
%col1: dimension location col2: non-zero pixel count
nonZeroInfo = zeros(rDim,1);  
meanInfo = zeros(rDim,1);
fprintf('Loading...');
for i=1:rDim
    a = regions(:,:,i);
    nonZeroInfo(i,1) = size(find(a),1); %store non-zero count
    meanInfo(i,1) = mean(find(a));
end
fprintf('Done.\n');

fig1 = figure;
fig2 = figure;

while cDim < size(regions,3)                                % for all dimensions
    counter = counter + 1;
    rDim = size(regions,3);
    fprintf('\n**Checking layer %d/%d\n',cDim,rDim);
    numOfNonZero = nonZeroInfo(cDim);                   % quantity of non-zero
                                                            % values in current dim
    if numOfNonZero <= threshold                            % we found a small region
        fprintf('  need to merge layer %d...\n',cDim);
         
         
        for largeRegDim=cDim+1:size(regions,3)               % check all layers after
            rDim = size(regions,3);
            if largeRegDim > rDim, break; end; % that to find one that 
                                                        % has more pixels then  
                                                        % our threshold
            numOfNonZero2 = nonZeroInfo(largeRegDim);
            if ( 1 ) ...
                    && distanceAway(meanInfo(cDim),meanInfo(largeRegDim),totPixels)

                fprintf('   merging layer %d/%d with %d',cDim,rDim,largeRegDim);
                                                % merging the first found large layer
                                                % with first found small layer.
                figure(fig1);
                imshow(regions(:,:,cDim));
                figure(fig2);
                imshow(regions(:,:,largeRegDim));

                regions(:,:,cDim) = regions(:,:,cDim) + regions(:,:,largeRegDim);                    
                                                    %delete larger layer.
                regions(:,:,largeRegDim) = [];
                nonZeroInfo(largeRegDim) = [];
                meanInfo(largeRegDim) = [];
                regionsRemoved = regionsRemoved + 1;
                fprintf('.\n');

            end %end if layer is big region
            
         end %end searching for next larger layer.
         
        fprintf(' Done: layer %d was merged with %d layers.\n',cDim,regionsRemoved);
        regionsRemoved = 0;
    else
        fprintf('layer %d exceeds threshold.\n',cDim);
    end %end if current layer is a small region
    cDim = cDim +  1;
end %end for all dimensions
fprintf('DONE.\n\n\n');

end


function [output] = distanceAway (a,b,totPixels)               
    % a&b are the avg non-zero pixel location for 2 layers
    
                        % if the avg pixel location of 
    if abs(a-b) < (totPixels/3000);                % a minus the avg-pixel-location
        output = 1;                             % of b < the total locations possible
    else                                        % divided by 4 ie: if the distance
        output = 0;                             % is about a sixteenth away
    end
end











