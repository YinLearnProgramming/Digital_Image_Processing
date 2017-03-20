figure
subplot(1,3,1)
imshow(I);
title('cameraman.png')

subplot(1,3,2)
imshow(c3);
title('corrupt3.png')

subplot(1,3,3)
imshow(LinearContrastStretching);
title('Linear contrast stretching')