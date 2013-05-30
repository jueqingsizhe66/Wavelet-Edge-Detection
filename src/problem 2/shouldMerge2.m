function [ result ] = shouldMerge2( img,THRES )
%{
%----------------------------------------------------


%----------------------------------------------------
%}

[imgrow imgcol layersLeft] = size(img);

firstlayer = img(:,:,1);
restOfLayers = img(:,:,2:layersLeft);
result = zeros(imgrow,imgcol);
fprintf('THRES: %d\n', THRES);
result = tryToMerge(result, firstlayer,restOfLayers,THRES,layersLeft-1,1); % try to merge first two layers..

end

function [res] = tryToMerge (result, r1,r2,THRES,layersLeft,iteration)
    fprintf('iteration %d. layers left=%d\n',iteration,layersLeft);
    r2dim = size(r2,3);
    if r2dim == 0
        fprintf('DONE\n');
        res = result;
        
        
    elseif NonZeroQuant(r2(:,:,1))<THRES 
        %if #of significant pixels in r2 < THRES
        %1st layer in r2 should be merged with r1
        result(:,:,end) = r2(:,:,1) + r1; %combine r1 and the first from r2 into a new layer in result
        layersLeft = layersLeft-1;    
        iteration = iteration + 1;
        res = tryToMerge(result, result(:,:,end), r2(:,:,2:end), THRES,layersLeft,iteration);        
        
    else
        %no need to merge,
        fprintf('NEW LAYER CREATED:r1 has %3d pixels,  r2 has %3d pixels\n',NonZeroQuant(r1),NonZeroQuant(r2(:,:,1)));
        if layersLeft == 1
            result(:,:,end+1) = r2(:,:,1);
            fprintf('got here\n');
            res = result;
        else
            %There was no need to merge r1 and r2
            %since r1+r2 was already put into result(line 77)
            %we move on...
            result(:,:,end+1) = r2(:,:,1);
            r2_1 = r2(:,:,1); 
            r2_2 = r2(:,:,2:end);
            layersLeft = layersLeft-1;
            iteration = iteration + 1;
            res = tryToMerge(result, r2_1, r2_2, THRES,layersLeft,iteration);
        end
    end
end

function [num] = NonZeroQuant (layer)
    %returns the number of significant pixels
    %in 'layer'
    [x y z] = find(layer);
    num = size(z,1);
end
