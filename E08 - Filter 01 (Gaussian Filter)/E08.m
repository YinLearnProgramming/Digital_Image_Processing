I = imread('input.png');
I = im2double(I);

sig = 3.0; %SD
wh = floor(2.5 * sig - 0.5);
w = zeros((wh*2+1),(wh*2+1));

[R, C] = size(I);
usedFilter = zeros(R,C);

O = size(w,1)-1;
P = size(w,2)-1;

%Visualization of kernel
for r=1:size(w,1)
    for c =1:size(w,2)
        x = c - (wh+1);
        y = r - (wh+1);
        w(r,c) = exp(-(x^2 + y^2)/(2*sig*sig));
        wSum = sum(w(:));
        filter = w /wSum;
    end
end
imagesc(w);title('Visualization of kernel');
colormap jet;

temp = 0;

for i=1:R-O
    for j=1:C-P
        temp = I(i:i+O,j:j+P).*filter; 
        usedFilter(i,j)=sum(temp(:));
    end
end

figure,imshow(usedFilter);title('Output of Gaussian filtering');


