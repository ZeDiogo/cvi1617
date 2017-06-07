function binary_image = vesselDetectionBright( originalImage )
%VESSELDETECTION Summary of this function goes here
%   Detailed explanation goes here
%     img = imread(sprintf('./frames/frame%.5d.jpg', 2390));
    img = originalImage;

    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);
%     binary_image = zeros(size(img, 1), size(img, 2));
    thrM = 254;
    thrD = 240;
    
    binary_image = and(max(max(red,green),blue)>thrM,max(max(red,green),blue) - min(min(red,green),blue) < thrD);
    binary_image = ~binary_image;
%     for i = 1:size(img,1)
%         for j = 1:size(img,2)
%             if (max([ red(i,j), green(i,j), blue(i,j)  ]) > thrM) && ...
%                     ((max([ red(i,j), green(i,j), blue(i,j) ]) - min([ red(i,j), green(i,j), blue(i,j) ])) < thrD)
%                 
%                 binary_image(i,j) = 1;
%             end
%         end
%     end
    
%     figure, imshow(binary_image), title('Binary Image from algorithm')
%     
% 
%     drawnow
%     pause
end

