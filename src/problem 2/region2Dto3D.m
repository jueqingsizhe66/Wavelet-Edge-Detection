function [ regionInfo3D ] = region2Dto3D( L )
%{
creates a 3d 'regionInfo3D' matrix, where each 
layer is a connected-region(*1) in 'L', where 'L' is
a segment of the grayscale/range dividing.

*1: regions are found using bwlabel
%}
[L_rows,L_cols, L_dim] = size(L);
L=bwlabel(L);
maxRegionNumber = max(find(L,3)); %# of regions in L
regionInfo3D = zeros(L_rows,L_cols);

for select = 1:maxRegionNumber
    for i=1:L_rows
        for j=1:L_cols
            if L(i,j) == select
                regionInfo3D(i,j,select) = L(i,j);
            end
        end
    end
end
end

