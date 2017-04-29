
clear all, close all;

imgg = imread('eight.tif');
figure, imshow(imgg);

imageN = imnoise(imgg, 'salt & pepper', 0.7);
figure, imshow(imageN);

K = filter2(fspecial('average',4),imageN)/255;
figure, imshow(K);

h = fspecial('average');
imageF2 = imfilter(imageN, h);
%imageF2 = medfilt2(imageN);

for i = 1 : 50
    %imageF2 = medfilt2(imageF2);
    imageF2 = imfilter2(imageF2,h)
    figure(1), imshow(imageF2);
    pause
end 