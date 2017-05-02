function [pos, areas] = detectObject( originalImage )
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here
    close all
    %originalImage = imread('./frames/scene00001.png');
   
    % Threshold the image to get a binary image (only 0's and 1's) of class "logical."
    % Method #1: using im2bw()
       normalizedThresholdValue = 0.4; % In range 0 to 1.
       %thresholdValue = normalizedThresholdValue * max(max(originalImage)); % Gray Levels.
       
       %----------------------------------------------------
       %originalImage = rgb2gray(originalImage);
       %binaryImage = imbinarize(originalImage, normalizedThresholdValue);       
       %figure(9), imshow(binaryImage)
       %----------------------------------------------------
       
       binaryImage = im2bw(originalImage, normalizedThresholdValue);       % One way to threshold to binary
       
       %----------------------------------------------------
    % Method #2: using a logical operation.
    %thresholdValue = 100;
    %binaryImage = originalImage > thresholdValue; % Bright objects will be chosen if you use >.
    % ========== IMPORTANT OPTION ============================================================
    % Use < if you want to find dark objects instead of bright objects.
    %binaryImage = originalImage < thresholdValue; % Dark objects will be chosen if you use <.
    thr = 50;

    % Removing central objects to get background image with corners
    BGImage = imfill(binaryImage, 'holes');
    % Applying background image as mask to remove corners and keep central
    % objects
    binaryImage(~BGImage) = 1;
    figure(2), imshow(binaryImage);

    minArea = 50;
    se = strel('disk',3);

    bw = imclose(binaryImage,se);
    figure(3), imshow(bw);
    bw = ~bw;
    figure(4), imshow(bw);
    
    
    [lb num]=bwlabel(bw);
    regionProps = regionprops(lb,'area','FilledImage','Centroid');
    
    inds = find([regionProps.Area]>minArea);
    
    
    pos = [];
    areas = [];
    for j=1:length(inds)
        [lin, col]= find(lb == inds(j));
        upLPoint = min([lin col]);
        pos = [pos; upLPoint];
        areas = [areas; regionProps(j).Area];
    end

    drawnow

end

