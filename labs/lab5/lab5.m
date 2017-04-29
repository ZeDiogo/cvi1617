

clear all, close all

% ------ Exemplo 1 --> Pedestre com Camisa Verde no campus IST --------%

vid = VideoReader('Movie_0002.avi');
nFrame = 40*25;
step = 20;

vid4D = zeros([vid.Height vid.Width 3 nFrame/step]);
figure,
k =1;
    for i=1 : step : nFrame
            i
            img = read(vid,i);
            vid4D(:,:,:,k)=img;
            imshow(img); drawnow
            k = k+1;
            %pause
    end
    
    bkg = median(vid4D,4);
    figure, imshow(uint8(bkg));
    
%------------------------------------------------------------------------%
vid = VideoReader('Movie_0002.avi');
nFrame = 40*25;
step = 20;
alfa = 0.1;

img = read(vid,1);
Bkg = zeros(size(img));

figure, hold on
k =1;
    for i=1 : step: nFrame
            i
            img = read(vid,i);
            Y = img;
            Bkg = alfa * double(Y) + (1-alfa) * double(Bkg);
            imshow(uint8(Bkg)); drawnow
    end
  
%------------------------------------------------------------------------% 
path = 'MATERIAL\Ist\'; frameIdComp = 4;
str = ['%s%.' num2str(frameIdComp) 'd.%s'];

nFrame = 548
step = 4;

vid4D = zeros([288 360 3 nFrame/step]);
figure;
for k = 1 : 1 : nFrame/step
      k
      str1 = sprintf(str,path,k,'jpg');
      img = imread(str1);
      vid4D(:,:,:,k)=img;
      imshow(img); drawnow
      hold off
end
bkg = median(vid4D, 4);
figure; imagesc(uint(bkg));




