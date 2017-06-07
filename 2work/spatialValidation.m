function result_image = spatialValidation( binary_image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  
img = binary_image;

%     imgTmp = imread(sprintf('./frames/frame%.5d.jpg', 1998));
%     img = vesselDetectionDark(imgTmp);
    
    thr = 40;
    maxArea = 10000;
    minArea = 100;
    R = 0;
    
%     filledImage = imfill(img, 'holes');
%     figure, imshow(filledImage), title('Filled binary image')

    se = strel('disk',2);
    bw = imdilate(img,se);

%     bw = ~bw;
    [lb num]=bwlabel(bw);
    blob = regionprops(lb,'area','FilledImage','Centroid');
%   figure, imshow(bw), title('Blob image')
    
    %Test 1 && 2 
    final = zeros(size(img,1), size(img,2));
    inds = find([blob.Area]<maxArea); 
    for i=1:length(inds)
        [lin, col] = find(lb == inds(i));
        if (min(lin) ~= 1) || (min(col) ~= 1) || (max(lin) ~= size(img,1)) || (max(col) ~= size(img,2))
            for j=1:size(lin,1)
                final(lin(j), col(j)) = 1;
            end
        end
    end
    bw = final;
%     figure, imshow(bw), title('after test 1 & 2')
    
    %1st test
%     inds = find([blob.Area]>maxArea); 
%     for i=1:length(inds)
%         [lin, col] = find(lb == inds(i));
%         for j=1:size(lin,1)
%             bw(lin(j), col(j)) = 0;
%         end
%     end
%     
%     bw = imdilate(bw,se);
%     figure(1), imshow(bw), title('after 1 test')
    
%     inds = find([blob.Area]<minArea);
%     for i=1:length(inds)
%         [lin, col] = find(lb == inds(i));
%         for j=1:size(lin,1)
%             bw(lin(j), col(j)) = 0;
%         end
%     end
    
    %2nd test
%     [lb num]=bwlabel(bw);
%     blob = regionprops(lb,'area','FilledImage','Centroid');
%     inds = find([blob.Area]);
%     for i=1:length(inds)
%         [lin, col] = find(lb == inds(i));
%         if (min(lin) == 1) || (min(col) == 1) || (max(lin) == size(img,1)) || (max(col) == size(img,2))
%             for j=1:size(lin,1)
%                 bw(lin(j), col(j)) = 0;
%             end
%         end
%     end
    
    %3rd test
    se = strel('disk',2);
    bigBlobImage = imdilate(bw,se);
%     figure, imshow(bw), title('Blob image')
    [lb num]=bwlabel(bigBlobImage);
    blob = regionprops(lb,'area','FilledImage','Centroid');
%     figure, imshow(bigBlobImage), title('after dilate')
    inds = find([blob.Area]>2000);
    for i=1:length(inds)
        [lin, col] = find(lb == inds(i));
        for j=1:size(lin,1)
            bw(lin(j), col(j)) = 0;
        end
    end
%     se = strel('disk',5);
%     bw = imerode(bw,se);
    
%     if length(inds)==0
%         disp('esta vazia')
%     end
%     figure, imshow(bw), title('after erode')
    
    %Get only biggest object
%     [lb num]=bwlabel(bw);
%     blob = regionprops(lb,'area','FilledImage','Centroid');
%     inds = find([blob.Area]==max([blob.Area]));
%     final = zeros(size(img,1), size(img,2));
%     for i=1:length(inds)
%         [lin, col] = find(lb == inds(i));
%         for j=1:size(lin,1)
%             final(lin(j), col(j)) = 1;
%         end
%     end
%     bw = final;
    
    %3rd test - too slow
%     [lb num]=bwlabel(bw);
%     blob = regionprops(lb,'area','FilledImage','Centroid');
%     centroids = [blob.Centroid];
%     inds = find([blob.Area]);
%     id = 1;
%     for i=1:(length(centroids)/2)
%         removePrimaryBlob = false;
%         xBlob=i*2-1;
%         yBlob=i*2;
%         
%         for j=1:(length(centroids)/2)
%             xOtherBlobs=i*2-1;
%             yOtherBlobs=i*2;
%             id = id+1;
%             if (centroids(xOtherBlobs)<(centroids(xBlob)+R)) && ...
%                     (centroids(xOtherBlobs)>(centroids(xBlob)-R)) && ...
%                     (centroids(yOtherBlobs)<(centroids(yBlob)+R)) && ...
%                     (centroids(xOtherBlobs)>(centroids(xBlob)-R))
%                 
%                 removePrimaryBlob = true;
%                 [lin, col] = find(lb == inds(j));
%                 for k=1:size(lin,1)
%                     disp(id)
% %                     bw(lin(k), col(k)) = 0;
%                 end
%             end
%             
%         end
% %         if removePrimaryBlob
% %             [lin, col] = find(lb == inds(i));
% %             for k=1:size(lin,1)
% %                 bw(lin(k), col(k)) = 0;
% %             end
% %         end
% 
%     end
    

    result_image = bw;
    
%     figure, imshow(bw), title('Blob image after removal')
%     drawnow
    
end

