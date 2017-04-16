f= imread('input_1.JPG');
Ro = size(f,1);
Co = size(f,2);
%find the center
rowMiddlePoint = Ro / 2;
columnMiddlePoint = Co / 2;

%gray it and double
f = rgb2gray(f);
%imshow(f);
%do median and Gaussian filter
matrixForGaussian = [3 3];  % siz
sigmaforGaussian = 0.5;    % std
sz   = (matrixForGaussian-1)/2;
std   = sigmaforGaussian;
[x,y] = meshgrid(-sz(2):sz(2),-sz(1):sz(1));
top   = -(x.*x + y.*y)/(2*std*std);
h     = exp(top);
h(h<eps*max(h(:))) = 0;
sumh = sum(h(:));
if sumh ~= 0
   h  = h/sumh;
end;

f = medfilt2(f);
f = imfilter(f, h, 'conv');
%imshow(f);
% get histrgarm
HistImage = imhist(f);
% normalize it
N = numel(f);% number of pxiel
normalizedHistImageN = HistImage/N;
% get CDF
cdf = cumsum(normalizedHistImageN);
%plot(cdf); %find the middle point
%pre thresholding
middle = 0.5;
if  middle <= 0.62
    middle = 0.62; % 0.6-0.68
elseif middle >= 0.84
    middle = 0.84;
end
% find the last index which is smaller middle
thelastIndex = find(cdf <= middle, 1, 'last');  
% do thresholding
f(f(:) < thelastIndex) = 0;
%imshow(f);

%get gradient
d = double(f);
%for i=1:size(d,1)-2
  %for j=1:size(d,2)-2
      %Gx = ((2*d(i+2,j+1)+d(i+2,j)+d(i+2,j+2))-(2*d(i,j+1)+d(i,j)+d(i,j+2)));
      %Gy = ((2*d(i+1,j+2)+d(i,j+2)+d(i+2,j+2))-(2*d(i+1,j)+d(i,j)+d(i+2,j)));

      %Gm(i,j)=sqrt(Gx.^2+Gy.^2);
   %end
%end
findGradient = imgradient(f, 'sobel');

%create 9*9 matrix
NineNine = ones(9,9);
filteredImage = stdfilt(findGradient, NineNine);
%imshow(filteredImage);
%make it 0 and 1 only
secondFilteredImage = filteredImage > 50;
preImage = medfilt2(secondFilteredImage);
%imshow(preImage);
%clear center of image(clear word)
noWordsImage = imfill(preImage, 'holes');
%imshow(noWordsImage);

sx = 0;
sy = 0;
sWidth = 0;
sHeight = 0;

K9ernelSize = 10;
KernelRowSize = 5;

%create scanner matrix
columnWindow = zeros(KernelSize+1,1);
rowWindow = zeros(1, KernelRowSize);

%row,from center to left,sx
for x = columnMiddlePoint : -1 : (KernelRowSize^2) 
    if noWordsImage(rowMiddlePoint,x-2:1:x+2) == rowWindow
        sx = x + KernelRowSize;
        break;
    end
end
%column,from center to top,sy
for y = rowMiddlePoint : -1 : (KernelRowSize^2)   
    if noWordsImage (y-5:1:y+5,columnMiddlePoint) == columnWindow
        sy = y - KernelSize-1;
        break;
    end
end
%row,from center to right,sWidth
for x = columnMiddlePoint : 1 : Co-(KernelRowSize^2)  
    if noWordsImage(rowMiddlePoint, x-2:1:x+2) == rowWindow
        sWidth = x - sx - KernelRowSize;
        break;
    end
end

if sWidth == 0
	sWidth = randi([sx (sx+1+rowMiddlePoint)]);
end
%column,from center to down,sHeight
for y = rowMiddlePoint : 1 : Ro-(KernelRowSize^2)
    if noWordsImage(y-5:1:y+5,columnMiddlePoint) == columnWindow
        sHeight = y - sy - KernelSize-1;
        break;
    end
end

if sHeight == 0
    sHeight = randi([sy (sy+1+columnMiddlePoint)]);
end