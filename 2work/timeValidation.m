function [ upLPoint, dWindow, final ] = timeValidation( img, upLPointHistory )
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
%     upLPointHistory = 0;
    %----------------------------------------------
    
    [lb num]=bwlabel(img);
    blob = regionprops(lb,'area','FilledImage','Centroid');
    R = 20;
    
%     final = img;
%     upLPoint = upLPointHistory;
%     dWindow = 5;
    if size(upLPointHistory, 1) == 3
        %choose the biggest object in the beginning
        disp('Initial frame')
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
        objectsInRadius = [];
        for i=1:length(inds)
            %check last known position to choose the right object
            [lin, col] = find(lb == inds(i));
            upLPoint = min([lin col]);
            dWindow  = max([lin col]) - upLPoint + 1;
            if (upLPoint(1) < (upLPointHistory(1,1)+R)) && (upLPoint(1) > (upLPointHistory(1,1)-R)) && ...
                    (upLPoint(2) < (upLPointHistory(1,2)+R)) && (upLPoint(2) > (upLPointHistory(1,2)-R)) 
                %inside radius - found new position
                disp('found object inside last object radius')
                %guardar o indice e a area
                objectsInRadius = [objectsInRadius; [ i, size(lin) ] ]
%                 for j=1:size(lin,1)
%                     final(lin(j), col(j)) = 1;
%                 end
%                 break
            end
        end
        
        %If found objects inside radius, choose biggest one
        if size(objectsInRadius)>0
            disp('choosing biggest object in radius')
            for i=1:size(objectsInRadius)
                if objectsInRadius(i,2) == max(objectsInRadius(:,2))
                    indexMax = objectsInRadius(i,1);
                    break
                end
            end
            [lin, col] = find(lb == inds(indexMax));
            upLPoint = min([lin col]);
            dWindow  = max([lin col]) - upLPoint + 1;
        end
        
        %Did not find new position
        if max(max(final)) == 0
            disp('Did not find new position')
            %Didn't find any object near last position - predict next
            %position
            if (upLPointHistory(1) ~= 0) && (upLPointHistory(2) ~= 0)
                disp('predicting new position')
                %last position is greater than 2 positions before
                if upLPointHistory(1,1) > upLPointHistory(2,1)
                    upLPoint(1) = upLPointHistory(1,1) + (upLPointHistory(1,1) - upLPointHistory(2,1));
                %last position is smaller than 2 positions before
                elseif upLPointHistory(1,1) < upLPointHistory(2,1)
                    upLPoint(1) = upLPointHistory(1,1) - (upLPointHistory(2,1) - upLPointHistory(1,1));
                end

                %last position is greater than 2 positions before
                if upLPointHistory(1,2) > upLPointHistory(2,2)
                    upLPoint(2) = upLPointHistory(1,2) + (upLPointHistory(1,2) - upLPointHistory(2,2));
                %last position is smaller than 2 positions before
                elseif upLPointHistory(1,2) < upLPointHistory(2,2)
                    upLPoint(2) = upLPointHistory(1,2) - (upLPointHistory(2,2) - upLPointHistory(1,2));
                end

            else
                %ignore - don't detect
    %                     upLPoint = [0,0];
    %                     dWindow = [0,0];
                disp('choosing biggest object')
                size(inds)
                max([blob.Area])
                %Didn't find any object near last position - choose the
                %biggest one              
                inds = find(max([blob.Area]));
                upLPoint = min([lin col]);
                dWindow  = max([lin col]) - upLPoint + 1;
%                 final = zeros(size(img,1), size(img,2));
                size(inds)
                for k=1:length(inds)
                    [lin, col] = find(lb == inds(k));
                    for j=1:size(lin,1)
                        final(lin(j), col(j)) = 1;
                    end
                end
            end
        end
    end     
    
    
    %Check estimate position is outside the image boundaries
    if upLPoint(1)>768 || upLPoint(2)>1024 || upLPoint(1)<1 || upLPoint(2)<1
%         upLPoint = [0,0];
        %Didn't find any object near last position - choose the
        %biggest one       
        disp('position outside')
        inds = find([blob.Area]==max([blob.Area]));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
        final = zeros(size(img,1), size(img,2));
        for k=1:length(inds)
            [lin, col] = find(lb == inds(k));
            for j=1:size(lin,1)
                final(lin(j), col(j)) = 1;
            end
        end
    end
    
%     imshow(img), title('Inside timeValidation');
%     rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[0 1 0],...
%                     'linewidth',1);
%     pause(0.6)
    disp('-----------------')
%     figure, imshow(final), title('Time validation image')  
%       rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
%                     'linewidth',1);
%     drawnow

end

