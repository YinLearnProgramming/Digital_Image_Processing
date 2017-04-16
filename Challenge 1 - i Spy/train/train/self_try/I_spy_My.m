function [r,c] = i_spy ( object_im, big_im, x )

targetImage = big_im;
objectImage = object_im;

grayTargetImage = rgb2gray(targetImage);
grayobjectImage = rgb2gray(objectImage);

crossCorrelation = normxcorr2(grayobjectImage(:,:,1),grayTargetImage(:,:,1));
[ypeak, xpeak] = find(crossCorrelation == max(crossCorrelation(:)));
[y, x] = ind2sub(size(crossCorrelation),xpeak(1));
position = [abs(gather(x-size(grayobjectImage,2))) abs(gather(y-size(grayobjectImage,1)))];
r = position(2);
c = position(1);