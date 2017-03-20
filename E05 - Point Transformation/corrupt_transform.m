clc; clear all; close all;
I = imread('cameraman.png');
c1 = imread('corrupt1.png');
c2 = imread('corrupt2.png');
c3 = imread('corrupt3.png');
c4 = imread('corrupt4.png');

invertImage = 255-I;
d2 = c1 - invertImage;
s2 = sum(d2(:));

AddConst = I + 100;
d1 = c2 - AddConst;
s1 = sum(d1(:));

gmin = min(I(:));
gmax = max(I(:));
gmin = double(gmin);
gmax = double(gmax);
gminout = 0;
gmaxout = 255;
LinearContrastStretching = ((gmaxout - gminout)/(gmax - gmin))*(I - gmin) + gminout;
d3 = c3 - LinearContrastStretching;
s3 = sum(d3(:));

multImage = I * 0.5;
d4 = c2 - multImage;
s4 = sum(d4(:));

f = double(I);
logImageFactor = log(f+1);
logImage = 255/(log(256));
logImage = uint8(logImage*logImageFactor);
d5 = logImage - c4;
s5 = sum(d5(:));

figure
subplot(2,5,1)
imshow(I);
title('cameraman.png')

subplot(2,5,2)
imshow(c1);
title('corrupt1.png')

subplot(2,5,3)
imshow(c2);
title('corrupt2.png')

subplot(2,5,4)
imshow(c3);
title('corrupt3.png')

subplot(2,5,5)
imshow(c4);
title('corrupt4.png')

subplot(2,5,6)
imshow(multImage);
title('Multiply constant * 0.5')

subplot(2,5,7)
imshow(invertImage);
title('Invert Image')

subplot(2,5,8)
imshow(AddConst);
title('Add constant')

subplot(2,5,9)
imshow(LinearContrastStretching);
title('Linear contrast stretching')

subplot(2,5,10)
imshow(logImage);
title('Log')