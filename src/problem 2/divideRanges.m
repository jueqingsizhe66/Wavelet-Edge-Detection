function [ RANGES ] = divideRanges( img, DIVIDER )
%{
%----------------------------------------------------
this function will take your input matrix, and return
a 3D matrix, where each layer of the returned matrix
contains only the pixels that fit into that percentage
of pixel values.

DIVIDER is the threshold, the higher the number, the 
tighter the ranges are, and less pixels will fall into
each percentage/range. 

ANY VALUES == 0 WILL NOT BE RETURNED IN ANY LAYER
(see line 32, > & <= part)

%----------------------------------------------------
%}

[i_row i_col] = size(img);
RANGES  = zeros(i_row,i_col,DIVIDER); %3d matrix, where each layer is a region

for x=1:i_row               %
    for y=1:i_col           %for all the pixels in img...
        pixel  = img(x,y);  %
        minrange = -1.00;   %
        
        for numerator=1:DIVIDER                             %
            maxrange = numerator/DIVIDER;                   %
            if ( (pixel>minrange) && (pixel<=maxrange) )    %   
                RANGES(x,y,numerator) = pixel;              % ...insert into appropriate
                break;                                      %    layer
            end                                             %
            minrange = maxrange;                            %
        end
        
    end
end 
end

