function [ result ] = maskapply( img, filter )
%GBLUR Summary of this function goes here
%   Detailed explanation goes here

gf = filter;

[i_row,i_col] = size(img);
[f_row, f_col] = size(gf);

result = [i_row,i_col];

for i= 1 : i_row %for each row... 1--> 512
  for j= 1 : i_col %inside of each row, for each column... aka, each pixel
      sum=0;
      for i2=1:f_row %for each row in the filter...
          %fprintf('\n');
          for j2=1 : f_col %for each col in the filter, aka each filter pixel
              %fprintf('.');
              %fprintf('so now we are at img(%d,%d) and gf(%d,%d)\n',i,j,i2,j2);
              %so now we are at img(i,j) and gf(i2,j2)
              x = i-3+i2;
              y = j-3+j2;
              if x<1 || y<1 || x>i_row || y>i_col 
                  val = 0;
              else
                val = img(x,y);
                sum = sum + ( val*gf(i2,j2) );
              end
          end
      end
      result(i,j) = sum;
  end
end

end
  
  
  
  