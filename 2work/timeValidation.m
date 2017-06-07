function [ upLPoint, dWindow, final ] = timeValidation( img, lastUpLPoint )
%TIME Summary of this function goes here
%   Detailed explanation goes here

    %----FOR DEBUG--------------------------------
%     img = imread(sprintf('./frames/frame%.5d.jpg', 1998));
%     if isBright(img)
%         binaryImage = vesselDetectionBright(img);
%     else    
%         binaryImage = vesselDetectionDark(img);
%     end
%     img = spatialValidation(binaryImage);
%     lastUpLPoint = 0;
    %----------------------------------------------
    
    [lb num]=bwlabel(img);
    blob = regionprops(lb,'area','FilledImage','Centroid');
    R = 10;
    
%     final = img;
%     upLPoint = lastUpLPoint;
%     dWindow = 5;
    if lastUpLPoint == 0
        %choose the biggest object in the beginning
        
        inds = find([blob.Area]==max([blob.Area]));
        final = zeros(size(img,1), size(img,2));
        for i=1:length(inds)
            [lin, col] = find(lb == inds(i));
            upLPoint = min([lin col]);
            dWindow  = max([lin col]) - upLPoint + 1;
            for j=1:size(lin,1)
                final(lin(j), col(j)) = 1;
            end
        end
    else
        
        inds = find([blob.Area]);
        final = zeros(size(img,1), size(img,2));
        for i=1:length(inds)
            %check last known position to choose the right object
            [lin, col]= find(lb == inds(1));
            upLPoint = min([lin col]);
            dWindow  = max([lin col]) - upLPoint + 1;
            
            if (lastUpLPoint(1) < (upLPoint(1)+R)) && (lastUpLPoint(1) > (upLPoint(1)-R)) && ...
                    (lastUpLPoint(2) < (upLPoint(2)+R)) && (lastUpLPoint(2) > (upLPoint(2)-R)) 
                %inside radius - found new position
                
                for j=1:size(lin,1)
                    final(lin(j), col(j)) = 1;
                end
                break
            else
                %Didn't find any object near last position - choose the
                %biggest one
                
                inds = find([blob.Area]==max([blob.Area]));
                final = zeros(size(img,1), size(img,2));
                for k=1:length(inds)
                    [lin, col] = find(lb == inds(k));
                    for j=1:size(lin,1)
                        final(lin(j), col(j)) = 1;
                    end
                end
            end
        end
    end     
    
  
%     figure, imshow(final), title('Time validation image')  
%       rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
%                     'linewidth',1);
%     drawnow

end

