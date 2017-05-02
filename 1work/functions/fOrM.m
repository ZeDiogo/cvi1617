close all

imgbk = imread('./frames/background.png');

thr = 45;
minArea = 30;

baseNum = 00001;
seqLength = 7818;

se = strel('disk',3);

figure;
for i=1000:seqLength
    imgfr = imread(sprintf('./frames/scene%.5d.png',baseNum+i));
    hold off
    imshow(imgfr);
    % não sei se o que está a cima vai para a main ou fica aqui...
    
    
     imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
        (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
        (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
    
    bw = imclose(imgdif,se);
    
    [lb num]=bwlabel(bw);
    
    [lb num]=bwlabel(bw);
    mite = regionprops(lb,'Area','FilledImage','Centroid');
    inds = find([mite.Area]>minArea);
    
    regnum = length(inds);
    areaVec = zeros((1),(2));
    
    for k=1:regnum
        areaVec(k) = mite(k).Area;
    end
    if areaVec(1) < areaVec(2)
        %mite1 is male
        [lin col]= find(lb == inds(1));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
            
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[0 0 1],...
                'linewidth',2);
        
        [lin col]= find(lb == inds(2));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
            
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
                'linewidth',2);
    elseif areaVec(1) > areaVec(2)
        %mite1 is male
        [lin col]= find(lb == inds(1));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
            
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[1 0 0],...
                'linewidth',2);
        
        [lin col]= find(lb == inds(2));
        upLPoint = min([lin col]);
        dWindow  = max([lin col]) - upLPoint + 1;
            
        rectangle('Position',[fliplr(upLPoint) fliplr(dWindow)],'EdgeColor',[0 0 1],...
                'linewidth',2);
    
  
    end
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
