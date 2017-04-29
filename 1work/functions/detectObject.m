function Boolean = detectObject(frameName)

%DETECTOBJECT Summary of this function goes here
%   Detailed explanation goes here

framesPath = './frames/'
frameName2 = strcat(framesPath, frameName)


image = imread(frameName2);
% Check to make sure that it is grayscale, just in case the user substituted their own image.
%[rows, columns, numberOfColorChannels] = size(originalImage);
% Do the conversion using standard book formula
%originalImage = rgb2gray(originalImage);
    
% Display the grayscale image.
%subplot(3, 3, 1);
imshow(image)



end

