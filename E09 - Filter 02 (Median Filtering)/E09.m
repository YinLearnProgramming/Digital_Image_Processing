I = imread('salt-pep.png');
[R C] = size(I);
h = zeros(R,C);

filter = zeros(3,3); %filter size 
w = ceil(size(filter,1)/2);%get the median value of the filter size
d = []; 

    for r = w+1:R-w
        for c = w+1:C-w
                t = I((r-w:r+w),(c-w:c+w));
                t = sort(t(:));
                h(r,c) = median(t(:));
        end
    end

h = uint8(h);
figure
subplot(1,2,1);
imshow(I),title('origin');

subplot(1,2,2);
imshow(h),title('after');

% let d be the vector of time with the same dimension as W
%plot ( W, d, '-ro' );
