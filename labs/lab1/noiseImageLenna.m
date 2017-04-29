clear all;


imgg = imread('lena512.bmp');

figure, imshow(imgg);
image = imnoise(imgg, 'salt & pepper', 0.05);
figure, imshow(image);

K = medfilt2(image, [3 3]);
figure, imshow(K);
