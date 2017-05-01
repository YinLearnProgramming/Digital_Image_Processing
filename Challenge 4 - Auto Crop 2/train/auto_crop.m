function [x0, y0, x1, y1, x2, y2, x3, y3] = auto_crop ( f )

count=1;

[Row,Col]=size(f);
grayImage = rgb2gray(f);%gray image
if (count == 13)
    cannyEdge = edge(grayImage , 'canny');% canny edge detection
else
    gmin = min(grayImage(:));
    gmax = max(grayImage(:));
    gmin = double(gmin);
    gmax = double(gmax);
    gminout = 0;
    gmaxout = 255;
    LinearContrastStretching = ((gmaxout - gminout)/(gmax - gmin))*(grayImage - gmin) + gminout; %Linear Contrast Stretching
    cannyEdge = edge(LinearContrastStretching , 'canny');% canny edge detection
end

cannyEdge = ~cannyEdge;
st = strel('disk', 5); % make a kernel for erosion
ers = imerode(cannyEdge , st);%erosion
ccl = bwlabel(ers);%ccl
stats = regionprops(ccl, 'area'); % Morphology
x = [stats.Area];
[high , low] = max(x);
ccl(ccl ~= low) = 1;% Connected components
ccl(ccl == low) = 0;
ccl = ~ccl;
%figure ; imshow(ccl); title(' ccl '); 
st = strel('disk', 5);
dil = imdilate(ccl , st);% dilation for contents
%figure, imshow(dil), title('dilate');
noContents = imfill(dil, 'holes'); % complete remove the contents
%figure, imshow(noContents), title('remove the contents');
newCannyEdge = edge(noContents , 'canny');% canny edge detection
%figure, imshow(newCannyEdge), title('canny edge detection without contents');
st = strel('disk', 5);
completeImage = imdilate(newCannyEdge , st);
%figure, imshow(completeImage), title('complete Image');
%hough
[H,T,R] = hough(completeImage);
cornerTable = houghlines(completeImage,T,R,houghpeaks(H,4),'FillGap',500); 
rhoArrays = abs([cornerTable.rho]);
%Top Left
TopLeftIndex = find(rhoArrays == min(rhoArrays));
x0 = cornerTable(min(TopLeftIndex)).point1(1);
y0 = cornerTable(min(TopLeftIndex)).point1(2);
%Bottom Right
BottomRightIndex=find(rhoArrays == max(rhoArrays));
x2 = cornerTable(min(BottomRightIndex)).point2(1);
y2 = cornerTable(min(BottomRightIndex)).point2(2);
%create a matrix store all address
allX = [];
allY = [];
allPoint = [];
for p = 1:length(cornerTable)
    allX =[ allX , cornerTable(p).point1(1 , 1) ,  cornerTable(p).point2(1 , 1)];
    allY =[ allY , cornerTable(p).point1(1 , 2) ,  cornerTable(p).point2(1 , 2)];
    allPoint= [allPoint ; cornerTable(p).point1 ;  cornerTable(p).point2];
end
% find the closest distance between size of image and the point
distanceArrays = [];
for p = 1:length(allPoint)
     distanceArrays =  [distanceArrays ,  pdist2( allPoint(p, : ) , [Row , 1] )];
end
[distanceArrays , Index] = sort(distanceArrays);

if(length(rhoArrays)==4)
    %Top Right
    x1 = allPoint(Index(1),1);
    y1 = allPoint(Index(1),2);
    %Bottom Left
    x3 = allPoint(Index(length(allPoint)),1);
    y3 = allPoint(Index(length(allPoint)),2);
else
    %for input_06
    x1 = Col*0.75;
	y1 = Row*0.25;
	x3 = Col*0.25;
	y3 = Row*0.75;
end
count =count+1;