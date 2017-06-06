% function result_image = spatialValidation( binary_image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%     img = binary_image;
    close all
    imgTmp = imread(sprintf('./frames/frame%.5d.jpg', 2390));
    img = vesselDetectionBright(imgTmp);
%     figure, imshow(img), title('binary image')
    
    thr = 40;
    maxArea = 10000;
    minArea = 100;
    
%     filledImage = imfill(img, 'holes');
%     figure, imshow(filledImage), title('Filled binary image')

    se = strel('disk',4);
    bw = imdilate(img,se);
    figure, imshow(bw), title('Blob image')
    
    bw = ~bw;
    [lb num]=bwlabel(bw);
    blob = regionprops(lb,'area','FilledImage','Centroid');
    
    inds = find([blob.Area]>maxArea);
    
    for i=1:length(inds)
        [lin, col] = find(lb == inds(i));
        for j=1:size(lin,1)
            bw(lin(j), col(j)) = 0;
        end
    end
    
     inds = find([blob.Area]<minArea);
    
    for i=1:length(inds)
        [lin, col] = find(lb == inds(i));
        for j=1:size(lin,1)
            bw(lin(j), col(j)) = 0;
        end
    end
    
    figure, imshow(bw), title('Blob image after removal')
    
    drawnow
    
% end

