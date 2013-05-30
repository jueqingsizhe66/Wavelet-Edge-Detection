clear all;
hw3_2a;
close all;
clearvars -except initRegMat;

origSection = (initRegMat(:,:,8));
L = bwlabel(initRegMat(:,:,8));

[L_rows,L_cols, L_dim] = size(L);
result = zeros(L_rows,L_cols);

SELECTOR = 74;
%{
creates a 3d 'result' matrix, where each 
layer contains a region in 'L', where 'L' is
a segment of the grayscale/range dividing.
%}
for select = 1:SELECTOR
    for i=1:L_rows
        for j=1:L_cols
            if L(i,j) == select
                result(i,j,select) = L(i,j);
            end
        end
    end
end

%{
since SELECTOR decides how many ranges 
well work with, and the above for loop
takes each range and inserts it into
result, the 3d-dim of result=selector.
%}
[r_row r_col r_dim] = size(result);

%{
for each layer in result, determine how
many pixels exist. If they are below a
certain threshold, merge that layer with
the one that comes after it. Check this 
newly created layer with the one in front
of that, if there are enough pixels in this
new layer, compare next one with the one 
after that.. loop until done.
%}

QUANTTHRES = 10;
c=1;

result2 = shouldMerge2(result, QUANTTHRES);

showSplitImages(0,8,[],result2)

%imshow(result,[]);



