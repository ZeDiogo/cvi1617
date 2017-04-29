clear all %cleans all variables in memory

veiculo = imread('veiculoGray.jpg');

figure; %new figure
imagesc(veiculo); colormap gray %assigns veiculo to figure

%noise = round(randn(size(veiculo))*50);
%imageN = max(min(veiculo+veiculo+uint8(noise),255),0);
imageN = imnoise(veiculo, 'gaussian', 0, 0.22);

figure;
imshow(imageN);

h = fspecial('average');
imageF = imfilter(imageN, h);
figure;
imshow(imageF);

