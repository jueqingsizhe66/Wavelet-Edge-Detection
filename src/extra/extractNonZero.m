function [ result ] = extractNonZero( img )
%EXTRACTNONZERO result=all values in input that are not 0
%   Detailed explanation goes here

[rowSize colSize dimSize] = size(img);
result = zeros(rowSize, colSize);

for i=1:rowSize*colSize
    if img(i) ~= 0
        result(i) = img(i);
    end
end

end

