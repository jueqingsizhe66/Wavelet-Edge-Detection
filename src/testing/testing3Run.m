logmask = [0 0 1 0 0;
           0 1 2 1 0;
           1 2 -16 2 1;
           0 1 2 1 0;
           0 0 1 0 0];

img = imread('Boats0.gif');
img = im2double(img);
%img = conv2(img,logmask);       
[a b] = testing3(img);

%{

regions = mergeLayers(checkAll(img,1,1,regions,THRES),regions);
totRegionCnt = 1;
for i=1:1
    for j=1:1
        fprintf('\b\b\b\b\b\b\b\b\b\b\b\b');
        fprintf('i=%3d,j=%3d\n',i,j);
         if regions(i,j) > 0 && i>1 && j>1 %pixel @ img(i,j) has already been claimed in another region
             break;
         else regions(i,j) == 0
             for ii=i:irow
                 for jj=j:irow
                    regions(:,:,totRegionCnt) = mergeLayers(checkAll(img,ii,jj,regions,THRES),regions);
                    %visualProgression(:,:,vpc) = regions(:,:);
                    %vpc = vpc + 1;
                 end
             end
        %else
         %   break;
        end    
             
             
%             for ii=1:rrow
%                 for jj=1:rcol
%                     if regions(i,j) == 0
%                         regions(:,:,totRegionCnt) = mergeLayers(checkAll(img,ii,jj,regions,THRES),regions);
%                         %visualProgression(:,:,vpc) = regions(:,:);
%                         %vpc = vpc + 1;
%                     else
%                         break;
%                     end
%                 end
%             end
            
            
            
%          end
    end
end


%}