close all

imgbk = imread('./frames/background.png');

thr = 45;
minArea = 30;

baseNum = 00001;
seqLength = 7818;

se = strel('disk',3);

figure;
for i=2060:seqLength
    imgfr = imread(sprintf('./frames/scene%.5d.png',baseNum+i));
%     hold off
%     imshow(imgfr);
    % n�o sei se o que est� a cima vai para a main ou fica aqui...
    
    
    normalizedThresholdValue = 0.35; % In range 0 to 1.     
    binaryImage = im2bw(imgfr, normalizedThresholdValue);       % One way to threshold to binary
    % Removing central objects to get background image with corners
    BGImage = imfill(binaryImage, 'holes');
    binaryImage(~BGImage) = 1;
    bw = imclose(binaryImage,se);
    bw = ~bw;
    
    hold off
    imshow(bw);
    disp(int2str(i));
   
    
    %------------------------------------------------------------------------------------------------------------
    % Create statistics notes
%     text_str = cell(1,1);
%    
%     text_str{1} = ['Frame: ' num2str(i,'%0.2f')];
%     
%     position = [10 440]; % [x y]
%     box_color = {'white'};
%   
%     bw = insertText(imgbk, position, text_str, 'FontSize', 14, 'BoxColor', box_color, 'BoxOpacity', 0.4);
    %imgfr = insertText(imgfr, position, text_str, 'FontSize', 14, 'BoxColor', box_color, 'BoxOpacity', 0.4);
    %------------------------------------------------------------------------------------------------------------
    
    
%      imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
%         (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
%         (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
%     
%     bw = imclose(imgdif,se);
    
   
    
    [lb num]=bwlabel(bw);
    mite = regionprops(lb,'Area','FilledImage','Centroid');
    inds = find([mite.Area]>minArea);
    
    regnum = length(inds);
     areaVec = zeros((1),(5));
    for k=1:regnum
        areaVec(k) = mite(k).Area;
    end    
    

        %get bigger object
        [sizeFemale, idFemale] = max(areaVec);
      
        %remove bigger object value from areas
        tmpFemale = sizeFemale; 
    
        areaVec(idFemale) = 0;
        %get second biggest object
        [sizeMale, idMale] = max(areaVec);
        areaVec(idFemale) = tmpFemale;
        
 

% 
% 
%     if areaVec(1) < areaVec(2)
%         mite1 is male
%         [lin col]= find(lb == inds(1));
%         upLPoint = min([lin col]);
%         dWindow  = max([lin col]) - upLPoint + 1;
%             
%         rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[0 0 1],...
%                 'linewidth',2);
%         
%         [lin col]= find(lb == inds(2));
%         upLPoint = min([lin col]);
%         dWindow  = max([lin col]) - upLPoint + 1;
%             
%         rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
%                 'linewidth',2);
    %if areaVec(1) > areaVec(2)
        %mite1 is female

        
        [lin col]= find(lb == inds(idFemale));

        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
            
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
                'linewidth',2);
       
        [lin col]= find(lb == inds(idMale));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
            
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[0 0 1],...
                'linewidth',2);
    
  
%     end
%     if regnum
%         for j=1:regnum
%             [lin col]= find(lb == inds(j));
%             upLPoint = min([lin col]);
%             dWindow  = max([lin col]) - upLPoint + 1;
%            
%             rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[0 1 0],...
%                 'linewidth',2);
%         end
%     end
    drawnow
end
