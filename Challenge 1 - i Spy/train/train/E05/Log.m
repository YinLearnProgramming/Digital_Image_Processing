clc; clear all; close all;
f=imread('cameraman.png');
I = imread('cameraman.png');
c1 = imread('corrupt1.png');
c2 = imread('corrupt2.png');
c3 = imread('corrupt3.png');
c4 = imread('corrupt4.png');
c = input('Enter the constant value, c = ');

[r,c]=size(f);
f = double(f);
for i=1:1:r
    for j=1:1:c
        logIm(i,j) = c*log(f(i,j)+1);
    end
end

imshow(logIm);