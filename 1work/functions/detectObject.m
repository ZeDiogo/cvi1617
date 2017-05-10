function [pos, areas, sizeDect] = detectObject( originalImage )
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here
   
    thr = 30;
    minArea = 30;
    se = strel('disk',4);
    imgfr = originalImage;
    imgbk = imread('./frames/background.png');
    %-1==========================================================================================
       normalizedThresholdValue = 0.40; % In range 0 to 1.
       %thresholdValue = normalizedThresholdValue * max(max(originalImage));
       
       binaryImage = im2bw(originalImage, normalizedThresholdValue);   
    % Removing central objects to get background image with corners
    BGImage = imfill(binaryImage, 'holes');
    % Applying background image as mask to remove corners and keep central
    % objects
    binaryImage(~BGImage) = 1;
    %figure(2), imshow(binaryImage);
    
    bw = imclose(binaryImage,se);
    %figure(3), imshow(bw);
    bw = ~bw;
    %figure(4), imshow(bw);
    %-2==========================================================================================
%     imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
%         (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
%         (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
%     bw = imclose(imgdif,se);    
    %============================================================================================

    
    
    
    [lb num]=bwlabel(bw);
    mite = regionprops(lb,'area','FilledImage','Centroid');
    
    inds = find([mite.Area]>minArea);
    
    
    pos = [];
    areas = [];
    sizeDect = [];
    for j=1:length(inds)
        [lin, col]= find(lb == inds(j));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
        pos = [pos; upLPoint];
        areas = [areas; mite(j).Area];
        sizeDect = [sizeDect; dWindow];
        
    end

    drawnow

end

