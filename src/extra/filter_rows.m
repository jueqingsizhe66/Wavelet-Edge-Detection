function [ result ] = filter_rows( output, img, pass )
%FILTER_ROWS Summary of this function goes here
%   Detailed explanation goes here

[o_row,o_col] = size(output); 



for n=1:o_row %for each row... 1--> 512
    for m=1:o_col-1 %inside of each row, for each column... 1--->512
        output(n,m) = h0filt(img(n,m*2),img(n,m*2+1));
        %fprintf('output1(%d,%d) = h0filt(img(%d,%d),img(%d,%d))\n',n,m,n,m*2,n,m*2+1);
    end
end
%result = mat2gray(output, [0 1]);
result = output;
end

