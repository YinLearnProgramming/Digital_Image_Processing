I = imread('model-t.png');
d = double(I);
[R,C] = size(I);
%kx and ky
kx = (1/8)*[1 0 -1;2 0 -2;1 0 -1];
ky = (1/8)*[1 2 1;0 0 0;-1 -2 -1];
%get gx and gy
gx = imfilter(d,kx);
gy = imfilter(d,ky);
% get gm
gm = sqrt((gx.^2) + (gy.^2));

T = 10;
g = gm>=T;


figure
subplot(2,2,1)
imshow(I),
title('origin image');

subplot(2,2,2)
imshow(gx, []),
title('gx');

subplot(2,2,3)
imshow(gy, []),
title('gy');

subplot(2,2,4)
imshow(gm,[]),title('edge after thresh');
