function [ result ] = shouldMerge( R1,R2,THRES )
%SHOULDMERGE Summary of this function goes here
%   Detailed explanation goes here

%2. if std(mean(R1),mean(R2)) < some THRESHOLD then they 
%   should be merged

if ( std(mean(R1),mean(R2)) < THRES )
    result = 1;
else
    result = 0;
end

end

