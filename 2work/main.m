clear all
close all
clc
oldpath = addpath('./frames/');

truePos = 0;
falsePos = 0;
falseNeg = 0;

groundTruth = load('2015-04-23-14-04-25_jai_eo.gt.txt');
baseNum = 1997;
finalFrame = 2999;
upLPoint = 0;
upLPointHistory = [0,0;0,0;0,0];

for frameNumber=2390:finalFrame
% for frameNumber=2245:2399
% frameNumber = 2390

    img = imread(sprintf('./frames/frame%.5d.jpg', frameNumber));
    
    if isBright(img)
%         binaryImage = vesselDetectionBright(img);
        binaryImage = buoyDetection(img);
        disp('In bright');
        isBri = 'Bright';
    else    
        binaryImage = vesselDetectionDark(img);
        disp('In dark');
        isBri = 'Dark';
    end
       
    binaryImageValid = spatialValidation(binaryImage);
%     figure(2), imshow(binaryImageValid), title(isBri)
    
    [upLPoint, dWindow, binaryImage] = timeValidation(binaryImageValid, upLPointHistory);    
    upLPointHistory = [upLPoint; upLPointHistory];
    
    upLeftCorner = [ groundTruth(frameNumber-baseNum+1, 2), groundTruth(frameNumber-baseNum+1, 3) ];
    dimension = [ groundTruth(frameNumber-baseNum+1, 4), groundTruth(frameNumber-baseNum+1, 5) ];
    drawBox(img, binaryImage, upLeftCorner, dimension, upLPoint, dWindow, frameNumber)
    
    [ truePos, falsePos, falseNeg ] = precRecall(upLeftCorner, dimension, upLPoint, dWindow, truePos, falsePos, falseNeg);
   
end