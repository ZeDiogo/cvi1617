clear all
close all
clc
oldpath = addpath('./frames/');

% Estruturas para guardar coordenadas
male_coords = [];
female_coords = [];
flagTouch = false;
flagCouple = false;
seenFirstCopula = false;
male_dist = 0;
female_dist = 0;
n_falhas = 0;
coupleStartFrame = 0;
CouplingDuration = 0;


baseNum = 1;
seqLength = 7818;

for i=0:seqLength

    imgfr = imread(sprintf('./frames/scene%.5d.png',baseNum+i));
    
    currentFrame = i;
    [male_coords, female_coords, flagTouch, flagCouple, pos, areas, sizeDect, coupleStartFrame, ...
        currentFrame, CouplingDuration] = ...
        updateLogic(imgfr, male_coords, female_coords, flagTouch, ...
        flagCouple, coupleStartFrame, currentFrame, CouplingDuration);
    
    frameNumber = i+1;
    [male_dist, female_dist, time_firstCopula, seenFirstCopula] = ...
        doStatistics(male_coords, female_coords, male_dist, female_dist, seenFirstCopula, frameNumber);
    
    statistics = [male_dist, female_dist, time_firstCopula, seenFirstCopula];
    
    drawBox(imgfr, statistics, pos, areas, sizeDect, male_coords, female_coords, flagTouch, CouplingDuration);
    
    
end