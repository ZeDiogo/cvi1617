function drawBox(imgfr, statistics, pos, areas, sizeDect)
%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

   
    imgbk = imread('./frames/background.png');

%---------------------------------------------------------------------------------------------------------
    % Create statistics notes
    text_str = cell(3,1);
   
    %[male_dist, female_dist, time_firstCopula, seenFirstCopula];
    seenFirstCopula = statistics(4);
    conf_val = [statistics(1) statistics(2) statistics(3)];
   
%    for ii=1:3
%       text_str{ii} = ['Confidence: ' num2str(conf_val(ii),'%0.2f') '%'];
%    end
    text_str{1} = ['Male distance: ' num2str(conf_val(1),'%0.2f') ' units'];
    text_str{2} = ['Female distance: ' num2str(conf_val(2),'%0.2f') ' units'];
    if seenFirstCopula==true   
        text_str{3} = ['Time First Copula: ' num2str(conf_val(3),'%0.2f') ' seconds'];
    else
        text_str{3} = ['Time First Copula: ' ' Not Occured Yet'];
    end
    position = [10 360; 10 400; 10 440]; % [x y]
    box_color = {'red','green','yellow'};
  
    imgbk = insertText(imgbk, position, text_str, 'FontSize', 14, 'BoxColor', box_color, 'BoxOpacity', 0.4);
    imgfr = insertText(imgfr, position, text_str, 'FontSize', 14, 'BoxColor', box_color, 'BoxOpacity', 0.4);
%-----------------------------------------------------------------------------------------------------------

    thr = 45;
    minArea = 30;

    se = strel('disk',3);

    %figure;

    hold off
    imshow(imgfr);
    
    
    %-1--------------------------------------------------------------------
%     imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
%         (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
%         (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
%     bw = imclose(imgdif,se);
    %-2--------------------------------------------------------------------
    %imgdif = im2bw(imgfr, 0.385);
    %BGImage = imfill(imgdif, 'holes');
    %imgdif(~BGImage) = 1;
    %bw = imclose(imgdif,se);
    %bw = ~bw;   
    %-3--------------------------------------------------------------------
    %imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
        (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
        (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
    %imshow(imgdif)
    %imgdif = im2bw(imgdif, 0.385);
    %BGImage = imfill(imgdif, 'holes');
    %imgdif(~BGImage) = 1;
    %bw = imclose(imgdif,se);
    %bw = ~bw;
    %imshow(bw)
    %----------------------------------------------------------------------
    
    %imshow(bw)
%     [lb, ~]=bwlabel(bw);
%     regionProps = regionprops(lb,'area','FilledImage','Centroid');
%     inds = find([regionProps.Area]>minArea);
%     
%     regnum = length(inds);
%     
%     if regnum
%         for j=1:regnum
%             [lin, col]= find(lb == inds(j));
%             upLPoint = min([lin col]);
%             dWindow  = max([lin col]) - upLPoint + 1;
%            
%             rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 1 0],...
%                 'linewidth',2);
%         end
%     end

    regnum = length(areas);
    if regnum
        for j=1:length(areas)
            upLPoint = pos(j, :);
            dWindow  = sizeDect(j, :);
            rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 1 0], 'linewidth',2);
            
        end
    end
    
    drawnow
end
