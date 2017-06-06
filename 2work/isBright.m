function isBright = isBright( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%     figure, histogram(img, 255), title('Image 2390')
    [N, EDGES] = histcounts(img, 255);
    [~, index] = max(N);
    colorMax = EDGES(index);
    
    if colorMax > 127
        isBright = true;
    else
        isBright = false;
    end

end

