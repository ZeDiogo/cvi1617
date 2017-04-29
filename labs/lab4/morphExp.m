%%
clear all, close all;

% ------------ primeiro exemplo, detecao da mioleira --------- %
%command: whos (shows values of variables)

img = imread('BrainMRI_Axial.jpg');
imshow(img); title('Original');
imgg = rgb2gray(img);
%figure, imhist(imgg);

BW = imgg>60;
figure,
subplot(2,3,1);
imshow(BW); title('Original BW');
se = strel('disk',3);

BW1 = imerode(BW, se);
subplot(2,3,1); imshow(BW1);title('Erosão');

BW2 = imdilate(BW,se);
subplot(2,3,3); imshow(BW2); title('Dilatação');

BW3 = imopen(BW, se);
subplot(2,3,4); imshow(BW3); title('Abertura');

[lb num] = bwlabel(BW3);
figure,
subplot(1,3,1);imshow(mat2gray(lb));title('Etiquetas');
stats = regionprops(lb);
areas = [stats.Area];
%dummy recebe o valor maximo de areas
%indM recebe o indice correspondente ao valor maximo de areas 
[dummy indM] = max(areas);
imgBr = (lb == indM);
subplot(1,3,2); imshow(imgBr); title('Maior área');
subplot(1,3,3);imshow(imgg.*uint8(imgBr));title('Cérebro');

%%
% ------------------ segundo exemplo ------------------- %

img = imread('rabbitBW.jpg');
imshow(img);title('Original');
pause
figure, hold on,
imshow(img);
se = strel('disk', 3);
for k = 1 : 30
    k
    img = imerode(img, se);
    imshow(img); drawnow
    pause(.2)
end

%%
% --------------------------- terceiro exemplo ----------------------- %

img = imread('rabbitBW.jpg');
imshow(img); title('Original');
pause
figure, hold on,
imshow(img);
se = strel('disk',3);
for k = 1 : 85
    k
    img = imdilate(img,se);
    imshow(img); drawnow
    pause(.1)
end





