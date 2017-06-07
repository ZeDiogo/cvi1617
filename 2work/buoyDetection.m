function binary_image = buoyDetection( originalImage )
%VESSELDETECTION Summary of this function goes here
%   Detailed explanation goes here
%     img = imread(sprintf('./frames/frame%.5d.jpg', 2390));
    img = originalImage;
    
    red = img(:,:,1);
    green = img(:,:,2);
    blue = img(:,:,3);  
    
    binary_image = zeros(size(img,1), size(img,2));
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            if (200<red(i,j)<237) && (green(i,j)<132) && (blue(i,j)<110)
                binary_image(i,j) = 1;
            end
        end
    end 

%     hold off
%     figure, imshow(binary_image), title('Binary Image from algorithm')
%     drawnow

end
