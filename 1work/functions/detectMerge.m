function Boolean = detectMerge( pos, areas )
%DETECTMerge Summary of this function goes here
%   Detailed explanation goes here
    %rad is the radious value around the bigger object
    rad = 1;
    distanceR = 5;
    %get bigger object
    [~, idBig] = max(areas);
    %remove bigger object value from areas
    areas(idBig) = 0;
    %get second biggest object
    [~, idSmall] = max(areas);
    
    %pos logic
    index = idSmall + (idSmall -1);
    smallX = pos(index);
    smallY = pos(index);

    index = idBig + (idBig -1);
    bigX = pos(index);
    bigY = pos(index+1);
    
    %check if smaller object is getting closer to the bigger object
    if (bigX-smallX)<=distanceR  && (bigY-smallY)<=distanceR
        Boolean = true;
    else
        Boolean = false;
    end
         
end
