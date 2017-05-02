function [pos, areas, sizeDect] = detectObject( originalImage )
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here
   
    thr = 50;
    minArea = 50;
    se = strel('disk',3);
    imgfr = originalImage;
    imgbk = imread('./frames/background.png');
    %-1==========================================================================================
%     % Method #1: using im2bw()
%        normalizedThresholdValue = 0.4; % In range 0 to 1.
%        %thresholdValue = normalizedThresholdValue * max(max(originalImage)); % Gray Levels.
%        
%        %----------------------------------------------------
%        %originalImage = rgb2gray(originalImage);
%        %binaryImage = imbinarize(originalImage, normalizedThresholdValue);       
%        %figure(9), imshow(binaryImage)
%        %----------------------------------------------------
%        
%        binaryImage = im2bw(originalImage, normalizedThresholdValue);       % One way to threshold to binary
%        
%        %----------------------------------------------------
%     % Method #2: using a logical operation.
%     %thresholdValue = 100;
%     %binaryImage = originalImage > thresholdValue; % Bright objects will be chosen if you use >.
%     %Option2:
%     % Use < if you want to find dark objects instead of bright objects.
%     %binaryImage = originalImage < thresholdValue; % Dark objects will be chosen if you use <.
%     
%     % Removing central objects to get background image with corners
%     BGImage = imfill(binaryImage, 'holes');
%     % Applying background image as mask to remove corners and keep central
%     % objects
%     binaryImage(~BGImage) = 1;
%     %figure(2), imshow(binaryImage);
%     
%     bw = imclose(binaryImage,se);
%     %figure(3), imshow(bw);
%     bw = ~bw;
%     %figure(4), imshow(bw);
    %-2==========================================================================================
    imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
        (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
        (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
    bw = imclose(imgdif,se);
    %============================================================================================
    
    [lb num]=bwlabel(bw);
    regionProps = regionprops(lb,'area','FilledImage','Centroid');
    
    inds = find([regionProps.Area]>minArea);
    
    
    pos = [];
    areas = [];
    sizeDect = [];
    for j=1:length(inds)
        [lin, col]= find(lb == inds(j));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
        pos = [pos; upLPoint];
        areas = [areas; regionProps(j).Area];
        sizeDect = [sizeDect; dWindow];

    % Detecting ghost detections
%    if regnum>=3 
        %FIXME
%       for j=1:regnum
%          [lin col]= find(lb == inds(j));
%           upLPoint = min([lin col]);
        
%            ghost_coords = ghost_coords + upLPoint
            
%        end
    % Detecting Male and Female
%    elseif regnum>0 && regnum<3
        %FIXME
       % miteArea1 = regionProps(1).Area
       % miteCentroid1 = regionProps(1).Centroid
       % miteArea2 = regionProps(2).Area
       % miteCentroid2 = regionProps(3).Centroid
        
       % if miteArea1 > miteArea2 && miteCentroid1 > miteCentroid2 
            %mite1 is the female as it is bigger
       % elseif miteArea1 < miteArea 2 && miteCentroid1 < miteCentroid2
            %mite2 is the female
        
    end

    drawnow

end

