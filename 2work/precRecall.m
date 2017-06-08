function [ truePos, falsePos, falseNeg, precision, recall, iou ] = precRecall( upLeftCorner, dimension, upLPoint, dWindow, truePos, falsePos, falseNeg )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    trueMat = zeros(768,1024);
    upLeftCorner = fliplr(upLeftCorner);
    dimension = fliplr(dimension);
    for lin=1:size(trueMat,1)
        for col=1:size(trueMat,2)
            if lin <= upLeftCorner(1)+dimension(1) && lin>=upLeftCorner(1) && ...
                    col <= upLeftCorner(2)+dimension(2) && col >= upLeftCorner(2)
                trueMat(lin,col) = 1;
            end
        end
    end
    
    predictMat = zeros(768,1024);
    for lin=1:size(predictMat,1)
        for col=1:size(predictMat,2)
            if lin <= upLPoint(1)+dWindow(1) && lin>=upLPoint(1) && ...
                    col <= upLPoint(2)+dWindow(2) && col >= upLPoint(2)
                predictMat(lin,col) = 1;
            end
        end
    end
   
    sum = trueMat + predictMat;
    TP = length(find(sum == 2));
    %TN = length(find(sum == 0));
    unionMinusIntersection = length(find(sum == 1));
    dif = trueMat - predictMat;
    FP = length(find(dif == -1));
    FN = length(find(dif == 1));
    numberTrueMat = length(find(trueMat == 1));
    numberPredictedMat = length(find(predictMat == 1));
    
    percentageTP = TP*100/numberTrueMat;
    percentageFP = FP*100/numberPredictedMat;
    
    if percentageTP > 30
       truePos = truePos + 1
    elseif percentageTP <= 30 || percentageFP == 100
        falsePos = falsePos + 1
    else
        falseNeg = 0;
    end
    
    precision = truePos / (truePos + falsePos)
    recall = truePos / (truePos + falseNeg)
    
    %-----------------------------------------
    %IoU
    iou = TP / (TP+unionMinusIntersection)
    
    
    
end

