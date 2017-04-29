clear all, close all;

imgg = imread('veiculoGray.jpg');

div=10;
N=10;

[L C] = size(imgg);
%MyImg = zeros(L,C,N);
MyImg(1:L,1:C,1) = imnoise(imgg, 'salt & pepper', 0.22);

for i=1 : N
    
    image(:,:,i) = imnoise(imgg,'salt & pepper', 0.22);
    figure(1);imshow(image(:,:,i));
    pause
end



