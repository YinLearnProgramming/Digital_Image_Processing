I = imread('valve.png');
grayImg = rgb2gray(I);
figure,imshow(I);title('input');
d = double(grayImg);
[R,C] = size(grayImg);
%kx and ky
kx = (1/8)*[1 0 -1;2 0 -2;1 0 -1];
ky = (1/8)*[1 2 1;0 0 0;-1 -2 -1];
%get gx and gy
gx = imfilter(d,kx);
gy = imfilter(d,ky);
figure, imshow(gx , []); title('Gradiant X');
figure, imshow(gy , []); title('Gradiant Y');
% get gm
gm = sqrt((gx.^2) + (gy.^2));
figure, imshow(gm ,[]);title('Gradiant Magnitude');
gd = atan2(gy,gx);

figure,imagesc(gd);title('Gradiant Direction');
colormap jet;


gmlocal = gm;
for r = 2 :R-1
    for c = 2:C-1
        v = gm(r,c);
        angle = gd(r,c);
        if(((-1/8*pi<=angle&&(angle<1/8*pi))&&((v<gm(r-1,c))||(v<gm(r+1,c)))))
            gmlocal(r,c) = 0;
        elseif(((1/8*pi<=angle&&(angle<3/8*pi))&&((v<gm(r-1,c-1))||(v<gm(r+1,c+1)))))
            gmlocal(r,c) = 0;
        elseif(((3/8*pi<=angle&&(angle<5/8*pi))&&((v<gm(r,c-1))||(v<gm(r,c+1)))))
            gmlocal(r,c) = 0;
        elseif(((5/8*pi<=angle&&(angle<7/8*pi))&&((v<gm(r-1,c+1))||(v<gm(r+1,c-1)))))
            gmlocal(r,c) = 0;
        end
    end
end
imshow(gmlocal ,[]);title('Maximum Suppression');