%%
% ------ Exemplo 1 --> Pedestre com Camisa Verde no campus IST --------%

vid = VideoReader('SonofMated6.avi');
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
    imwrite(uint8(bkg),'background_test.png');
    %%
