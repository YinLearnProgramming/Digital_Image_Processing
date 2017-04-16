function [ct] = how_many ( prefix, ct_f, num_f )%folder name, grading frames, frame number

%i is an array of integers from 1 to the number of frames
for i = 1:num_f
    fn = sprintf ( '%sFRM_%05d.png%', prefix, i);%load an image
    img = imread ( fn );
    grayImg = rgb2gray(img);%make it gray
    smallGrayImg = grayImg(1:4:end,1:4:end); % subimage
    if i == 1
        backgroundImage = smallGrayImg;
    end
end

for x=1:numel(ct_f)
    fn = sprintf ( '%sFRM_%05d.png%', prefix, ct_f(x));
    I = imread ( fn );
    grayImage = rgb2gray(I);
    smallGrayImg = grayImage(1:4:end,1:4:end); % subimage
    filter = medfilt2(smallGrayImg,[3 3]);
    resultImage = filter - backgroundImage; %find difference
    gmin = min(resultImage(:));
    gmax = max(resultImage(:));
    gmin = double(gmin);
    gmax = double(gmax);
    gminout = 0;
    gmaxout = 255;
    LinearContrastStretching = ((gmaxout - gminout)/(gmax - gmin))*(resultImage - gmin) + gminout; %Linear Contrast Stretching
    level = graythresh(LinearContrastStretching);
    BW = imbinarize(LinearContrastStretching,level);%make it Binary
    fgImg = imdilate(BW, strel('square',3));%dilate
    fgImg = imerode(fgImg, strel('square',3));%erosion
    ccl = bwlabel(fgImg,4); %CCL

    status = regionprops(ccl,'Area');%small region removal
    allArea = [status.Area];
    if prefix == 'video1/'
        limit = 11.5;
    else
        limit = 5;
    end
    for i = 1:numel(allArea)
        if (allArea(i) < limit)
            ccl(ccl==i)=0;
        else
        ccl(ccl==i)=1;
        end
    end
    [L,count] = bwlabel(ccl,4);% find answer
    ct(x) = count;
end
