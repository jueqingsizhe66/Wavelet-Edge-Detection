function [ result ] = findzerocross( img )
%FINDZEROCROSS
%loop through rows, find pixels that are zero-crossings, others val = 0;
%loop through col, find pixels that are zero-crossings, others val = 0;

[i_row, i_col] = size(img);
result = zeros(i_row,i_col);

%i parses through the rows
%j parses through the cols

%{
THRES = 2;

for i=1:i_row
    for j=1:i_col
        if i+THRES > i_row || j+THRES>i_col
            %...
        else
            window = 1;
            while window ~= THRES
                if ... %both + and - then edge...
                    img(i,j)<0 && img(i,j+window)<0 || ...
                    img(i,j)>0 && img(i,j+window)>0 ||
                    img(i,j)<0 && img(i+window,j)>0 ...
                end
                    
            end
        end
    end
end

%}

%%%%%CHECK ROW BY ROW FOR ZERO-CROSSINGS
for i= 1:i_row %for each row... 
    for j= 1:i_col %inside of each row, for each column... aka, each pixel
        second_pixel_col_location = j + 2;
        if second_pixel_col_location > i_col 
            %nothing...
        else
           if ( img(i,j)<0 && img(i,second_pixel_col_location)>0 ) || ...
                   ( img(i,j)>0 && img(i,second_pixel_col_location)<0 )
               %zero crossing detected at img(i,j+1);
               %fprintf('zero crossing detected at img(%d,%d)\n',i, j+1);
               result(i,j+1) = img(i,j+1);
               %result(i,j+1) = 1;
           end
        end
    end
end
%%%%%%

clear j i;

%%%%%CHECK COL BY COL FOR ZERO-CROSSINGS
for j = 1:i_col %for each col... 
    for i= 1:i_row %inside of each col, for each row... aka, each pixel
        second_pixel_row_location = i + 2;
        if second_pixel_row_location > i_row
            %nothing...
        else
           if ( img(i,j)<0 && img(second_pixel_row_location,j)>0 ) || ...
                   ( img(i,j)>0 && img(second_pixel_row_location,j)<0 )
               %zero crossing detected at img(i,j+1);
               %fprintf('zero crossing detected at img(%d,%d)\n',i, j+1);
               result(i,j+1) = img(i,j+1);
               %result(i+1,j) = 1;
           end
        end
    end
end
%%%%%%

end

