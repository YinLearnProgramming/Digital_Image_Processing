
prefix = ('key');
for img=1:4
    fn = sprintf('%s.%d.jpg',prefix,img);
    f = imread(fn);
    f = imread('key.1.jpg');
    f = im2bw(f,graythresh(f));
    f = ~f;
    f = imclose(f,strel('square',5));
    l = bwlabel(f);
    stats = regionprops(l,'Area');
    Area = [stats.Area];
    disp(max(Area));
    l(l~=find(Area==max(Area)))=0;
    l(l==find(Area==max(Area)))=1;
    
    stats = regionprops(l,'Centroid');
    centroid = [stats.Centroid];
    disp('Centroid');
    disp(centroid);
    centroid = floor(centroid);
    
    [stats] = regionprops(l,'MajorAxisLength');
    majorAxis = stats.MajorAxisLength;
    
    [stats]= regionprops(l,'MinorAxisLength');
    minorAxis = stats.MinorAxisLength;
    
    D = sqrt( (majorAxis/2)^2 + (minorAxis/2)^2);
    disp('Maximum Distance');
    disp(D);
    D= floor(D);
    r= [];
    
    for theta = 0:359
        for d = 1:D
            R = floor(centroid(2) + d * sind(theta));
            C = floor(centroid(1) + d * cosd(theta));
            
            if(l(R,C)== false)
                r(359-theta+1) = d;
                break;
            end
            
        end
    end
    
    maximum_value = max(max(r(:)));
    disp('Max of R');
    disp(maximum_value);
    
    maxTheta = find(maximum_value == r)
    maxTheta = maxTheta(1);
    thetaNew = [0:359];
    rNewValue = []; 
    for thetaNew = 1:360
        i = maxTheta + thetaNew;
%         disp(i);
        if(i > 360)
            i = abs(i - 360);
        end
        rNewValue(thetaNew) = r(i);
    end
    
    r = r/maximum_value;
    rNewValue = rNewValue / max(rNewValue(:));
    hold on;
    plot([0:359],r,'-r'); title('Scale Normalization vs Scale and Rotation Normalization');
    hold off;
    hold on ;
    plot([0:359],rNewValue,'-b');
    hold off;
end