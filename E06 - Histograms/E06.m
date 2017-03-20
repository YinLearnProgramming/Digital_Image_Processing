I = imread('unequal.png');
HistImage = imhist(I); % histogram of input
%plot(HistImage);title('histogram of image'); 
N = numel(I);% number of pxiel
HistImageN = HistImage / N; % normalize
c = cumsum(HistImageN); %CDF of input

g = c(I+1); % avoid 0 index
HistG = imhist(g); % hist of equalized
N2 = numel(g); 
HistN2 = HistG/N2; % normalize
CSG = cumsum(HistN2); % CDF of equalized 

figure
subplot(2,4,1)
imshow(I);
title('origin image')

subplot(2,4,2)
plot(HistImage)
title('histogram of image') 

subplot(2,4,3)
plot(HistImageN);
title('normalized histogram of input')

subplot(2,4,4)
plot(c);
title('CDF of input')

subplot(2,4,5)
imshow(g);
title('histogram equalized image')

subplot(2,4,6)
plot(HistG)
title('histogram of image') 

subplot(2,4,7)
plot(HistN2);
title('normalized histogram of image')

subplot(2,4,8)
plot(CSG);
title('CDF of G')
