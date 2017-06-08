function drawBox( imgfr, binaryImage, upLeftCorner, dimension, upLPoint, dWindow, frameNumber, precisionVec, recallVec, frameNumberVec, iouVec)
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

    hold off
    figure(1)
    subplot(2, 3, 1); imshow(imgfr);
        %GroundTruth
        rectangle('Position',[upLeftCorner dimension],'EdgeColor',[0 0 1],...
                    'linewidth',1);
    
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
                    'linewidth',1);
                
    subplot(2, 3, 2); imshow(binaryImage);
        %Estimated
        if upLPoint ~= 0
            rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
                    'linewidth',1);
        end
    title(sprintf('Frame: %.5d', frameNumber));
   
    hold on
    subplot(2, 3, 4); plot(frameNumberVec, precisionVec), axis([1998, 2999, -0.1, 1]), title('Precision');
    
    subplot(2, 3, 5); plot(frameNumberVec, recallVec), axis([1998, 2999, -0.1, 1]), title('Recall');
    
    subplot(2, 3, 3); plot(frameNumberVec, iouVec), axis([1998, 2999, -0.1, 1]), title('IoU');
     
    drawnow
end
