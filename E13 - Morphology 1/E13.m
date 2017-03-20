I = imread('rice.png');
I = im2bw(I);
[R,C] = size(I);

B = ones(3);
f = false(size(I));
for r=2:(R-1)
    for c=2:(C-1)
        g = I(r-1:r+1,c-1:c+1);
        if (sum(sum(g & B))>0)
            f(r,c) = true;
        else
            f(r,c) = false;
        end
    end
end
figure;imshow(f);title('3*3 ones dilate');

B = ones(7);
f1 = false(size(I));
for r=4:(R-3)
    for c=4:(C-3)
        g = I(r-3:r+3,c-3:c+3);
        if (sum(sum(g & B))>0)
            f1(r,c) = true;
        else
            f1(r,c) = false;
        end
    end
end
figure;imshow(f1);title('7*7 ones dilate');

f2 = false(size(I));
B = ones(3);
for r=2:(R-1)
    for c=2:(C-1)
        g = I(r-1:r+1,c-1:c+1);
        if ((g & B)==B)
            f2(r,c) = true;
        else
            f2(r,c) = false;
        end
    end
end
figure;imshow(f2);title('3*3 ones erosion');

f3 = false(size(I));
B = ones(7);
for r=4:(R-3)
    for c=4:(C-3)
        g = I(r-3:r+3,c-3:c+3);
        if ((g & B)==B)
            f3(r,c) = true;
        else
            f3(r,c) = false;
        end
    end
end
figure;imshow(f3);title('7*7 ones erosion');