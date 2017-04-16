function [r,c] = i_spy ( object_im, big_im, x )

targetImage = big_im; %load big image
objectImage  = object_im;% load small image
targetImage = rgb2gray(targetImage); % gray big image
objectImage = rgb2gray(objectImage); %gray smail image
crossCorrelation  = normxcorr2(objectImage(:,:,1),targetImage(:,:,1)); %get cross-correlation
AbsCrossCorrelation = abs(crossCorrelation(:));
[ypeak, xpeak] = max(AbsCrossCorrelation);% Find peak in cross-correlation.
getSizeOfCrossCorrelation = size(crossCorrelation);
[y, x] = ind2sub(getSizeOfCrossCorrelation,xpeak(1)); %use ind2sub to Subscripts
yoffSet = abs(gather(y-size(objectImage,1))); %Account for the padding
xoffSet = abs(gather(x-size(objectImage,2))); 
position = [xoffSet yoffSet]; %get the position
r = position(2); %return r
c = position(1); %return c
