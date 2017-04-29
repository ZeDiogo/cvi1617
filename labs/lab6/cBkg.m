


%%
clear all, close all
% ----- exemplo 1 - pedestre comm camisa verde no campus IST -- %
vid = VideoReader('Movie_0002.mp4');
nFrame = 40*25;
step = 20;

vid4D = zeros([vid.Height vid.Width 3 nFrame/step]);
figure,
k = 1;

for i=1:step:nFrame
    i
    img = read(vid, i);
    vid4D(:,:,:,k) = img;
    imshow(img); drawnow
    k = k+1;
    %pause
end

bkg = median(vid4D,4);
figure, imshow(uint8(bkg));
%%
% exemplo 1 A -> pedestre com camisa verde no campus IST






%%
% exemplo 2 -> pedestres e carros no campus IST ------ %
path = 'Ist/'; frameIdComp = 4;
str = ['%s%.' num2str(frameIdComp) 'd.%s'];

nFrame = 548;
step = 4;

vid4D = zeros([288 360 3 nFrame/step]);
figure;
for k = 1 : 1 : nFrame/step
    k
    str1 = sprintf(str, path, k, 'jpg');
    img = imread(str1);
    vid4D(:,:,:,k)=img;
    imshow(img); drawnow
    hold off
    %pause(0.2)
    
end
bkg = median(vid4D,4);
figure; imagesc(uint8(bkg));
%%

% exemplo 3 -> 
    










