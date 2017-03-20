I = imread('input1.png');
T = 158; %158% for t 0:255
g = I>=T;
imshow(g);

[R,C] = size(g);
omegal = 0;
omegal2 = 0;

for r =1:R
    for c = 1:C
        if(g(r,c)==0)
            omegal = omegal +1;
        elseif(g(r,c)~=0)
            omegal2 = omegal2 +1;
        end
    end
end

sum1 = 0.0;
sum2 = 0.0;
m1 = 0.0;
m2 = 0.0;
for r=1:R
    for c =1:C
        if (I(r,c)<T)
            sum1 = sum1+ double(I(r,c));
        elseif(I(r,c)>=T)
            sum2 = sum2 + double(I(r,c));
        end
        if(I(r,c)<T)
            m1 = double(I(r,c)) +m1;
        else
            m2 = double(I(r,c)) +m2;
        end
    end
end

%B = omegal * omegal2 *(m1-m2)^2;

