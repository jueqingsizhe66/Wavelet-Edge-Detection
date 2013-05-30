function [ result ] = findFirstDeriv( img )
%find strong edges that have 1st deriv support...
%img is our zero-cross'd image
%deriv @ g(i,j) = g(i,j) - g(i,j-1);

[i_row, i_col] = size(img);
result = zeros(i_row,i_col);

%i parses through the rows
%j parses through the cols
THRESHOLD = 2;

%%%%%CHECK ROW BY ROW FOR FIRST-DERIV
for i= 1:i_row %for each row... 
    for j= 1:i_col %inside of each row, for each column... aka, each pixel
        second_pixel_col_location = j - 1;
        if second_pixel_col_location <= 0 
            %nothing...
        else
               %calc 1st deriv img(i,j)....
               deriv = img(i,j) - img(i,j-1);
               if deriv > THRESHOLD
                %fprintf('deriv = %d\n',deriv);
                result(i,j) = deriv;
               end
        end
    end
end
%%%%%%

%%%%%CHECK COL BY COL FOR ZERO-CROSSINGS
for j = 1:i_col %for each col... 
    for i= 1:i_row %inside of each col, for each row... aka, each pixel
        second_pixel_row_location = i - 1;
        if second_pixel_row_location <= 0 
            %nothing...
        else
           if 1==1
               %calc 1st deriv img(i,j)....
               deriv = img(i,j) - img(i-1,j);
               if deriv > THRESHOLD
                %fprintf('deriv = %d\n',deriv);
                result(i,j) = deriv;
               end
           end
        end
    end
end
%%%%%%

%{
[r_row,r_col] = size(result);

result2 = zeros(r_row,r_col);

ROWMAX = 20;
COLMAX = 20;

rowOfTempMax = -10000;
colOfTempMax = -10000;
tempMax = 0;

i = 1;
j = 1;


while i<r_row%1-->max row
    while j<r_col %1-->max col
        for neighbor_row = 0:ROWMAX-1 %1,2,3
            for neighbor_col = 0:COLMAX-1 %1,2,3
                if ( i+neighbor_row > r_row ) || ( j+neighbor_col > r_col )
                    %nothing...
                else
                    currentVal = result(i+neighbor_row,j+neighbor_col);
                    if currentVal > tempMax
                        tempMax = currentVal;
                        rowOfTempMax = i+neighbor_row;
                        colOfTempMax = j+neighbor_col;
                    end
                end
            end
        end
        if rowOfTempMax>0 && colOfTempMax>0
            result2(rowOfTempMax,colOfTempMax) = tempMax;
        end
        tempMax = -1000;
        j = j+COLMAX;
        %fprintf('i=%d, j = %d\n', i,j);
    end
    j = 1;
    i = i+ROWMAX;
    %fprintf(', i = %d\n',i);
end

%}





end

