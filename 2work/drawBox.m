function drawBox( imgfr, upLeftCorner, dimension )
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

    hold off
    imshow(imgfr);

        %male
        rectangle('Position',[upLeftCorner dimension],'EdgeColor',[0 0 1],...
                    'linewidth',2);
    
    drawnow
end
