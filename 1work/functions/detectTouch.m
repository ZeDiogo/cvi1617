function flagTouch = detectTouch( pos, areas )
%DETECTTOUCH Summary of this function goes here
%   Detailed explanation goes here
    
    %rad is the radious value around the bigger object
    rad = 1;
    
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
    
    %check if smaller object is in the radious of the bigger object
    if (bigX-rad)<=smallX && (bigX+rad)>=smallX && (bigY-rad)<=smallY && (bigY+rad)>=smallY
        flagTouch = true;
    else
        flagTouch = false;
    end
         
end

