clear all
close all
clc
oldpath = addpath('./frames/');

baseNum = 1997;
seqLength = 2999;
% for i=baseNum:seqLength
    i=1998
    frameNumber=i;
    imgfr = imread(sprintf('./frames/frame%.5d.jpg',i));
    [upLeftCornerX, upLeftCornerY, xLength, yLength] = getBoxFromFile('2015-04-23-14-04-25_jai_eo.gt.txt', frameNumber);
    
    
% end