function Boolean = detectMerge( pos, areas )
%DETECTMerge Summary of this function goes here
%   Detailed explanation goes here
    %distanceR is the distanceRious value around the bigger object
    distanceR = 3;
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
    %case split male and female
%     if smallX<=(bigX+distanceR) && smallX>=(bigX-distanceR) && smallY<=(bigY+distanceR) && smallY>=(bigY-distanceR)
    if (bigX-smallX)>=distanceR  && (bigY-smallY)>=distanceR
        Boolean = false;
    else
    % case merge    
        Boolean = true;
    end
         
end

