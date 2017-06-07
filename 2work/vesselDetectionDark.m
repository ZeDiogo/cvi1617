function binary_image = vesselDetectionDark( originalImage )
%VESSELDETECTION Summary of this function goes here
%   Detailed explanation goes here
%     img = imread(sprintf('./frames/frame%.5d.jpg', 1998));
    img = originalImage;
    
    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);
    binary_image = ones(size(img, 1), size(img, 2));
    thrM = 80;
    thrD = 100;
    bw = zeros(size(img,1),size(img,2));
   
%     for i = 1:size(img,1)
%         for j = 1:size(img,2)
%             if (max([ red(i,j), green(i,j), blue(i,j)  ]) > thrM) && ...
%                     ((max([ red(i,j), green(i,j), blue(i,j) ]) - min([ red(i,j), green(i,j), blue(i,j) ])) < thrD)
%                 
%                 binary_image(i,j) = 0;
%             end
%         end
%     end
    
      
    binary_image = and(max(max(red,green),blue)>thrM,max(max(red,green),blue) - min(min(red,green),blue) < thrD);

   
%     figure, imshow(binary_image), title('Binary Image from algorithm')
%     drawnow

end
