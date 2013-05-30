function [ result ] = filter_cols( output, img, pass )
%FILTER_ROWS Summary of this function goes here
%   Detailed explanation goes here

[o_row,o_col] = size(output); 


for m=1:o_col %for each col... 1--> 512
    for n=1:o_row-1 %inside of each col, for each row... 1--->512
        output(n,m) = h0filt(img(n*2,m),img(n*2+1,m));
        %fprintf('output(%d,%d) = h0filt(img(%d,%d),img(%d,%d))\n',n,m,n*2,m,n*2+1,m);
    end
end
%result = mat2gray(output, [0 1]);
result = output;
end

