I = false(100,100);
I(25,25) = true;
I(25:75,25) = true;
I(25,25:75) = true;
I(75,25:75) = true;
I(25:75,75) = true;
I(75,75) = true;
figure;imshow(I);title('Create a synthetic edge image');

R = size(I,1);
C = size(I,2); 
d = ceil(sqrt(R^2 + C^2));
a = zeros(d+d+1,179+1);

for r = 1:R
    for c = 1:C
       if I(r,c) == true
           for theta = 1:180
                p = round(r*cosd(theta-1) + c*sind(theta-1));
                p = p+1+d;
                a(p,theta) = a(p,theta)+1;
           end
           if((r==25)&&(c==25))
           figure;imshow(a);title('visualization of one sinusoidal curve');
           end
       end
    end
end
figure;imshow(a,[]);title('accumulator array visualized');
% i dont know about ind2sub, so i do other way.
[x,y] = find(a == max(max(a)));
index = [x,y];
index(:,1) = index(:,1) - 1 - d;
index(:,2) = index(:,2) - 1;
