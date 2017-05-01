f = imread('input_07.JPG');
grayImage = rgb2gray(f);%gray image
grayImage = medfilt2(grayImage,[20 20]);
gmin = min(grayImage(:));
gmax = max(grayImage(:));
gmin = double(gmin);
gmax = double(gmax);
gminout = 0;
gmaxout = 255;
LinearContrastStretching = ((gmaxout - gminout)/(gmax - gmin))*(grayImage - gmin) + gminout; %Linear Contrast Stretching
cannyEdge = edge(LinearContrastStretching , 'canny');% canny edge detection
st = strel('disk', 5);
dil = imdilate(cannyEdge , st);% dilation for contents
ccl = bwlabel(dil);%ccl
ccl = ~ccl;
figure, imshow(ccl), title('dilate');