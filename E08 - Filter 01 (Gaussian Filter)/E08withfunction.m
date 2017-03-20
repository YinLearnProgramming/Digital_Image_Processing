I = imread('input.png');
I = im2double(I);
Iblur1 = imgaussfilt(I,2);
Iblur2 = imgaussfilt(I,10);
Iblur3 = imgaussfilt(I,20);

figure
subplot(1,4,1)
imshow(I)
title('Original image')

subplot(1,4,2)
imshow(Iblur1)
title('Smoothed image, \sigma = 2')

subplot(1,4,3)
imshow(Iblur2)
title('Smoothed image, \sigma = 10')

subplot(1,4,4)
imshow(Iblur3)
title('Smoothed image, \sigma = 20')