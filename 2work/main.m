clear all
close all
clc
oldpath = addpath('./frames/');
groundTruth = load('2015-04-23-14-04-25_jai_eo.gt.txt');
baseNum = 1997;
finalFrame = 2999;
% for frameNumber=baseNum:finalFrame
% for frameNumber=1998:1998
frameNumber = 2390

    img = imread(sprintf('./frames/frame%.5d.jpg', frameNumber));
    
    if isBright(img)
        binaryImage = vesselDetectionBright(img);
    else    
        binaryImage = vesselDetectionDark(img);
    end
        
    upLeftCorner = [ groundTruth(frameNumber-baseNum+1, 2), groundTruth(frameNumber-baseNum+1, 3) ];
    dimension = [ groundTruth(frameNumber-baseNum+1, 4), groundTruth(frameNumber-baseNum+1, 5) ];
    drawBox(binaryImage, upLeftCorner, dimension)
   
% end