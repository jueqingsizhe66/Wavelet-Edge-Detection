%{
Version 0.01

Written by Gagandip Singh, gagandip@buffalo.edu, 2012. 
Free for anyone to use or modify.

This function prepares the position information needed when creating
figures by dividing up your monitor into quadrants, and inserting that
information into a matrix.

Example Usage:
quadrants = setUpQuadrants(1,1,8,200,200,300,300);
myFigure = figure('Name','My New Figure','Position',quadrants{4});

This example code will create a figure on the 4th quadrant on your 2nd
monitor

INPUTS: numOfMonitors, numOfDisplays, numOfQuads, quadW, quadH, imgW, imgH )
RETURNS: a cell array of position information

input# description
1: number of monitors you currently have
2: the display you want the quadrants to show on (1 is far left, 2 is
   after that, and so on)
3: max number of quadrants you want to show on the screen
4: horizontal spacing between figures
5: vertical spacing between figures
6: width of the figure
7: height of the figure
%}

function [ quadrant ] = setUpQuadrants( numOfMonitors, display, numOfQuads, ...
                                        spacerW,spacerH, imgW, imgH )
                                    
scrsz = get(0,'ScreenSize'); %scrsz(3):width, scrsz(4):height (1&2 irrelev)
i_row = imgW;
i_col = imgH;

MAXQUADS = numOfQuads-1;
%quadrant = zeros(MAXQUADS,4);
quadrant = cell(numOfQuads,1);
screenw = scrsz(3)/numOfMonitors;
screenh = scrsz(4);

distFromBot = screenh;
distFromLeft = spacerW + (scrsz(3)/numOfMonitors);

cnt2 = 1;

while(distFromBot>=0)
    while(distFromLeft<screenw)
        %                   distFromLeft   distFromBot  w       h
        quadrant{cnt2} = [ distFromLeft, distFromBot, i_col, i_row ];
        distFromLeft = distFromLeft + spacerW;
        cnt2 = cnt2 + 1;
        if (size(quadrant,2) > MAXQUADS)
            break;
        end
    end
    distFromLeft = spacerW; 
    distFromBot  = distFromBot - (spacerH);
    if (size(quadrant,2) > MAXQUADS)
        break;
    end
end

quadsGenerated = max(find(~cellfun(@isempty,quadrant)));

if quadsGenerated<numOfQuads
    fprintf([...
            'WARNING: Quadrant information has been generated, but due\n',  ...
            'to your inputs (probably quadrant spacing is too high)\n',     ...
            'not all %d quadrants have been generated. Quadrant information\n',     ...
            'only %d quadrants have been generated\n',     ...
            ''      ...
            ],numOfQuads,quadsGenerated); 
end

end

