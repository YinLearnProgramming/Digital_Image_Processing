I = imread('doc.jpg');
figure;imshow(I);title('Input');
G = rgb2gray(I);
G = G(1:4:end,1:4:end); %reduce size
BW = edge(G,'Canny');
figure;imshow(BW);title('Edge Image');

[R C]=size(BW);
d=ceil(sqrt(R^2+C^2));
a=zeros(2*d+1,180);

for r=1:R
    for c=1:C
        if(BW(r,c)==1)
            for theta=1:180
                p=floor(c*cosd(theta-1)+r*sind(theta-1));
                p=p+d+1;
                a(p,theta)=a(p,theta)+1;
            end
        end
    end
end
figure,imagesc(a);colormap jet;title('Visualisation of Accumulator Array Without Non-Max Suppression');

[Row, Col] = size(a);

for r = 6: Row-5
    for c = 6: Col-5
        maxValue= max(max(a(r-5:r+5,c-5:c+5)));
        if(a(r,c)== maxValue)
            a(r-5:r+5,c-5:c+5)=0;
            a(r,c)=maxValue;
        else
            a(r,c) = 0;
        end
    end
end
figure,imagesc(a);colormap jet;title('Visualisation of Accumulator Array With Non-Max Suppression');

img4point = a;
for i=1:4 
    [x,y] = find(img4point==max(max(img4point)));
    X(i) = x;
    Y(i) = y;
    img4point(x,y) = 0;
end

rho = X - d - 1;
theta = Y - 1;
colorIm = G;
%colorIm = insertShape ( colorIm, 'line', [rho(1), theta(1),
%rho(2),theta(2)]); % not WORK!!!!
figure;imshow(colorIm);title('Output of top lines');
hold on;
xValue = 1:300;
for i=1:4
   yValue = -cotd(theta(i))*xValue + rho(i)*cscd(theta(i));
        plot(xValue,yValue,'y');
    
end 
hold off ;