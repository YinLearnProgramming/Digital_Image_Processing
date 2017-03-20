I = imread('mountain.png');
meanMountainColumn = mean (I);

darkestCol = find (meanMountainColumn == min (meanMountainColumn));

[R,C] = size(I);
for r = 1:R
    for c = 1:C
        flipImage(r,c) = I(R-r+1,c);
    end
end

halfImage = zeros(R/2,C/2,'uint8');
for r = 1:R/2
    for c = 1:C/2
        halfImage(r,c) = I(r*2-1,c*2-1); 
    end
end

myHist = zeros(1,256);
for r = 1:R
    for c = 1:C
        P = I(r,c);
        myHist(P+1) = myHist(P+1)+1;
    end
end
