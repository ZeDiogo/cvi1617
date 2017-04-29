function Boolean = detectObject(frameName)

%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

%framesPath = './frames/'
%imgbk = imread('./frames/scene00001.png');
imgbk = imread('./frames/background.png');

[m1, m2, m3] = size(imgbk)
% Check to make sure that it is grayscale, just in case the user substituted their own image.
%[rows, columns, numberOfColorChannels] = size(originalImage);
% Do the conversion using standard book formula
%originalImage = rgb2gray(originalImage);
    
% Display the grayscale image.
%subplot(3, 3, 1);

thr = 20;
minArea = 100;

baseNum = 00001;
seqLength = 7862;

se = strel('disk',3);

figure;
for i=0:seqLength
    imgfr = imread(sprintf('./frames/scene%.5d.png',baseNum+i));
    hold off
    imshow(imgfr);
    
    imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
        (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
        (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
    
    bw = imclose(imgdif,se);
    %imshow(bw)
    [lb num]=bwlabel(bw);
    regionProps = regionprops(lb,'area','FilledImage','Centroid');
    inds = find([regionProps.Area]>minArea);
    
    regnum = length(inds);
    
    if regnum
        for j=1:regnum
            [lin col]= find(lb == inds(j));
            upLPoint = min([lin col]);
            dWindow  = max([lin col]) - upLPoint + 1;
           
            rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 1 0],...
                'linewidth',2);
        end
    end
    drawnow
end

