I = imread('rice.png');
figure;imshow(I);title('input');
BI = im2bw(I);
figure;imshow(BI);title('Binary image');
ccl = bwlabel(BI,4);
ccl = uint16(ccl);
figure;imshow(ccl,[]);title('perform connected component labeling');
status = regionprops(ccl,'Area');
allArea = [status.Area];

for i = 1:numel(allArea)
    if (allArea(i) < 50)
        ccl(ccl==i)=0;
    else
        ccl(ccl==i)=1;
    end
end
figure, imshow(ccl,[]); title('small region removal');

SE = strel('arbitrary',[1 1 1; 1 1 1; 1 1 1]);
erodedBW = imerode(ccl,SE);
figure;imshow(erodedBW,[]);title('Boundary');
b = ccl-erodedBW;
%b =imbinarize(ccl-erodedBW);
figure;imshow(b,[]);title('Boundary Extraction');