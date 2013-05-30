function [ maxrow,maxcol,maxdim ] = findLocationOfMax( input )
%FINDLOCATIONOFMAX Summary of this function goes here
%   Detailed explanation goes here

[a b c] = size(input);

maxvalue = -1;
maxrow = 0;
maxcol = 0;
maxdim = 0;


for i=1:a
    for j=1:b
        for k=1:c
            if input(i,j,k) > maxvalue
                maxvalue = input(i,j,k);
                maxrow = i;
                maxcol = j;
                maxdim = k;
            end
        end
    end
end



end

