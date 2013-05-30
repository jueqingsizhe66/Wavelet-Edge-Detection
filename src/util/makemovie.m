[a b] = testing3('Boats0.gif');

vro = VideoWriter('BigBoats.avi');
vro.FrameRate = 30;
open(vro);

[x y z] = size(b);

for k=1:z
    writeVideo(vro,b(:,:,k));
end

close(vro);
clear all;