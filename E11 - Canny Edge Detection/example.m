clear;
close all;
f = imread('valve.png');
figure, imshow(f); title('Input');
f = rgb2gray(f);
f = double(f);

sigma = 2;
f  = imgaussfilt(f , sigma);
kx = 1.0/8.0 * [1 0 -1 ; 2 0 -2 ; 1 0 -1];
ky = transpose(kx);

gx = imfilter(f , kx , 'conv');
gy = imfilter(f , ky , 'conv');
figure, imshow(gx , []); title('Gradiant X');
figure, imshow(gy , []); title('Gradiant Y');


gm = sqrt(gx.^2 + gy.^2);
gd = atan2(gy , gx);

figure, imshow(gd,[]);title('Gradiant Direction');
colormap jet;

figure, imshow(gm , []);title('Gradiant Magnitude');
[R,C] = size(f);

gmTemp = gm;
for r=2:(R-1)
    for c=2:(C-1)
        v=gm(r,c);
        newAngle=0;
        if((((-1/8*pi<=gd(r,c))&& (gd(r,c)<pi*1/8))||((-7/8*pi>gd(r,c))&& (gd(r,c)>=pi*7/8))) )
            newAngle=0;
        elseif((((pi*1/8<=gd(r,c))&& (gd(r,c)<pi*3/8))||((-5/8*pi>gd(r,c))&& (gd(r,c)>=-7/8*pi))) )
            newAngle=45;
        elseif((((pi*3/8<=gd(r,c))&& (gd(r,c)<pi*5/8))||((-3/8*pi>gd(r,c))&& (gd(r,c)>=-5/8*pi))) )
            newAngle=90;
        elseif((((pi*5/8<=gd(r,c))&& (gd(r,c)<pi*7/8))||((-1/8*pi>gd(r,c))&& (gd(r,c)>=-3/8*pi))) )
            newAngle=135;
        end
        
        if(newAngle == 0 &&  ( v < gm(r  , c - 1) || v  < gm(r , c + 1)))
               gmTemp(r ,  c) = 0;
           elseif(newAngle == 45 &&  ( v < gm(r - 1 , c - 1) || v  < gm(r + 1, c + 1)))
               gmTemp(r ,  c) = 0;  
          elseif(newAngle == 90 &&  ( v < gm(r - 1  , c ) || v  < gm(r + 1 , c )))
               gmTemp(r ,  c) = 0;
           elseif(newAngle == 135 &&  ( v < gm(r + 1 , c - 1) || v  < gm(r - 1 , c + 1)))
               gmTemp(r ,  c) = 0;
         end
    end
end

figure;
imshow(gmTemp , []);title('Maximum Suppression');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hm = imhist(gmTemp);
[n,v] = max(hm);
figure, plot(hm); title('Hisotgram');

hist= imhist(gmTemp);
hist= hist/numel(gm);
figure,plot(hist);
cdf= cumsum(hist);
figure,plot(cdf);

%%% Alpha = 10 % of edge pixels.
%%% Beta
alpha = 0.9;beta=0.2;
tHigh= 0;
tLow = 0;

for i=1:256
    if(cdf(i)> alpha)
        tHigh = i;
        break;
    end
end
tHigh
% alpha = 10;
% beta = 0.2;
% tHigh = 10;
tLow = 2;       % beta*tHigh;
bEdge1 =  edgeLinking1(gmTemp , tLow ,tHigh);
figure, imshow(bEdge1); title('Edge Detection After Hysteresis');
