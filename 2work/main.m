clear all
close all
clc
oldpath = addpath('./frames/');
groundTruth = load('2015-04-23-14-04-25_jai_eo.gt.txt');
baseNum = 1997;
finalFrame = 2999;
upLPoint = 0;
% for frameNumber=2390:finalFrame
for frameNumber=2624:finalFrame
% frameNumber = 2390

    img = imread(sprintf('./frames/frame%.5d.jpg', frameNumber));
    
    if isBright(img)
%         binaryImage = vesselDetectionBright(img);
        binaryImage = buoyDetection(img);
        disp('In bright');
    else    
        binaryImage = vesselDetectionDark(img);
        disp('In dark');
    end
    
    binaryImageValid = spatialValidation(binaryImage);
%     figure, imshow(binaryImageValid), title('toda escura')
    
    [upLPoint, dWindow, binaryImage] = timeValidation(binaryImageValid, upLPoint);    
    
    upLeftCorner = [ groundTruth(frameNumber-baseNum+1, 2), groundTruth(frameNumber-baseNum+1, 3) ];
    dimension = [ groundTruth(frameNumber-baseNum+1, 4), groundTruth(frameNumber-baseNum+1, 5) ];
    
    drawBox(img, binaryImageValid, upLeftCorner, dimension, upLPoint, dWindow, frameNumber)
   
end