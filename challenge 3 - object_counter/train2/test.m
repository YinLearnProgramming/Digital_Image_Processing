I = imread('1.png');
I2 = imread('2.png');

grayImage = rgb2gray(I);
grayImage2 = rgb2gray(I2);

smallGrayImg = grayImage(1:4:end,1:4:end); % subimage
smallGrayImg2 = grayImage2(1:4:end,1:4:end); % subimage

%H = fspecial('Gaussian',[3 3],1.76);
%GaussF = imfilter(smallGrayImg,H);

filter = medfilt2(smallGrayImg,[3 3]);

%filteredImage = conv2(smallGrayImg, ones(3)/9,'same');
%filteredImage = uint8(filteredImage);
filter2 = medfilt2(smallGrayImg2,[3 3]); %filter
resultImage = filter2 - filter; %find difference

gmin = min(resultImage(:));
gmax = max(resultImage(:));
gmin = double(gmin);
gmax = double(gmax);
gminout = 0;
gmaxout = 255;
LinearContrastStretching = ((gmaxout - gminout)/(gmax - gmin))*(resultImage - gmin) + gminout; %Linear Contrast Stretching
%figure;imshow(LinearContrastStretching);title('LCS');
level = graythresh(LinearContrastStretching);
level2 = graythresh(resultImage);
BW = imbinarize(LinearContrastStretching,level);%make it Binary
BW2 = imbinarize(resultImage,level);
%figure;imshow(BW2);title('Binary without LCS');
%figure;imshow(BW);title('Binary with LCS');

%fgImg = imerode(BW, strel('square',3));
%figure;imshow(fgImg);title('erosion');
%fgImg = imdilate(fgImg, strel('square',3));
%figure;imshow(fgImg);title('dilate');
fgImg = imdilate(BW, strel('square',3));%dilate
%figure;imshow(fgImg);title('dilate');
fgImg = imerode(fgImg, strel('square',3));%erosion
%figure;imshow(fgImg);title('erosion');
ccl = bwlabel(fgImg,4); %CCL

status = regionprops(ccl,'Area');%small region removal
allArea = [status.Area];
for i = 1:numel(allArea)
    if (allArea(i) < 11.5)
        ccl(ccl==i)=0;
    else
        ccl(ccl==i)=1;
    end
end
figure;imshow(ccl);title('small region removal');
[L,count] = bwlabel(ccl,4);% find answer
