% Otsu on input1.png
I = imread('input1.png');
bcd = zeros(256);
bcd2 = zeros(256);
%get Otsu
for t=0:255
    T = t;
    g = I>=T;

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
    
    m1 = 0.0;
    m2 = 0.0;
    cou1 =0;
    cou2 = 0;
    for r=1:R
        for c =1:C
            if(I(r,c)<T)
                m1 = double(I(r,c)) +m1;
                cou1 = cou1+1;
            else
                m2 = double(I(r,c)) +m2;
                cou2 = cou2+1;
            end
        end
    end
    avg1 = m1/cou1;
    avg2 = m2/cou2;
    
    b = omegal * omegal2 *((avg1-avg2)^2);
    bcd(t+1)=b;
    
end
m = max(bcd);
figure;plot(bcd);title('bcd');

% Local thresholding on image2.png
I2 = imread('input2.png');
for t2 =0 : 255
    T2 = t2;
    g2 = I2>=T2;
    [R2,C2] = size(g2);
    
    omegalOfI2 = 0;
    omegal2OfI2 = 0;
    for r2 =1:R2
        for c2 = 1:C2
            if(g2(r2,c2)==0)
                omegalOfI2 = omegalOfI2 +1;
            elseif(g2(r2,c2)~=0)
                omegal2OfI2 = omegal2OfI2 +1;
            end
        end
    end
    
    m1OfI2 = 0.0;
    m2OfI2 = 0.0;
    cou1OfI2 =0;
    cou2OfI2 = 0;
    
    for r2=1:R2
        for c2 =1:C2
            if(I2(r2,c2)<T2)
                m1OfI2 = double(I2(r2,c2)) +m1OfI2;
                cou1OfI2 = cou1OfI2+1;
            else
                m2OfI2 = double(I2(r2,c2)) +m2OfI2;
                cou2OfI2 = cou2OfI2+1;
            end
        end
    end
    avg1ofI2 = m1OfI2/cou1OfI2;
    avg2ofI2 = m2OfI2/cou2OfI2;
    
    b2 = omegalOfI2 * omegal2OfI2 *((avg1ofI2-avg2ofI2)^2);
    bcd2(t2+1)=b2;
end
m2 = max(bcd2);
figure;plot(bcd2);title('bcd2');