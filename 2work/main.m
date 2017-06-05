clear all
close all
clc
oldpath = addpath('./frames/');
matrix = load('2015-04-23-14-04-25_jai_eo.gt.txt');
baseNum = 1997;
finalFrame = 2999;
for frameNumber=baseNum:finalFrame

    imgfr = imread(sprintf('./frames/frame%.5d.jpg', frameNumber));
    
    upLeftCorner = [ matrix(frameNumber-baseNum+1, 2), matrix(frameNumber-baseNum+1, 3) ];
    dimension = [ matrix(frameNumber-baseNum+1, 4), matrix(frameNumber-baseNum+1, 5) ];
    drawBox(imgfr, upLeftCorner, dimension)
    
end