function drawBox( imgfr, upLeftCorner, dimension, upLPoint, dWindow )
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

    hold off
    imshow(imgfr);

        %GroundTruth
        rectangle('Position',[upLeftCorner dimension],'EdgeColor',[0 0 1],...
                    'linewidth',1);
    
        %Estimated
        rectangle('Position',[upLPoint dWindow],'EdgeColor',[1 0 0],...
                    'linewidth',1);
                
    drawnow
end
