function drawBox( imgfr, binaryImage, upLeftCorner, dimension, upLPoint, dWindow, frameNumber )
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

    hold off
    
    subplot(1, 2, 1); imshow(imgfr);
        %GroundTruth
        rectangle('Position',[upLeftCorner dimension],'EdgeColor',[0 0 1],...
                    'linewidth',1);
    
    subplot(1, 2, 2); imshow(binaryImage);
        %Estimated
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
                    'linewidth',1);
    title(sprintf('Frame: %.5d', frameNumber));
    drawnow
end
