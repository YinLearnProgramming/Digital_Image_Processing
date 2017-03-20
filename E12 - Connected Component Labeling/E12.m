clear all; close all; clc;
I = imread('rice.png');
g = im2bw(I);

[R,C] = size(I);
cclIm = zeros(R,C);
L=1;

for r=2:R
    for c=2:C
        if(g(r,c)==true)
            %get left
            left = g(r,c-1);
            %get top
            top = g(r-1,c);
            
            if((left==false)&&(top==false))
                cclIm(r,c)=L;
                L = L+1;
            elseif((left==false)&&(top==true))
                cclIm(r,c)= cclIm(r-1,c);
            elseif((left==true)&&(top==false))
                cclIm(r,c)= cclIm(r,c-1);
            elseif((left==true)&&(top==true))
                minValue= min((cclIm(r-1,c)),(cclIm(r,c-1)));
                cclIm(r,c)= minValue;
                cclIm(r-1,c)=minValue;
                cclIm(r,c-1)=minValue;
            end
        end
    end
end

cmap = rand(L,3);

figure('name','origin');
imshow ( I,[] ),title('input');
colormap(cmap);
figure('name', 'imagesc');
imagesc(cclIm),title('ccl');
colormap(cmap);