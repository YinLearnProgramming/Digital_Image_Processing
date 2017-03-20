% Otsu on input1.png
I = imread('input1.png');
bcd = zeros(256);

%get Otsu
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
    
m = max(bcd);
figure;plot(bcd);title('bcd');