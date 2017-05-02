function value = isMale( male_coords )
%ISMALE Summary of this function goes here
%   Detailed explanation goes here
    
    rad = 2;
    
    index = size(male_coords, 1);
    
    maleX = male_coords(index, 1);
    maleY = male_coords(index, 2);
    
    maleXOld = male_coords(index-1, 1);
    maleYOld = male_coords(index-1, 2);
    
    if maleX<=(maleXOld+rad) && maleX>=(maleXOld-rad) && maleY<=(maleYOld+rad) && maleY>=(maleYOld-rad)
        value = true;
    
    else
        value = false;
        
    end
    

end

