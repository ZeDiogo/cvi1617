function value = isFemale( female_coords )
%ISMALE Summary of this function goes here
%   Detailed explanation goes here
    
    rad = 2;
    
    index = size(female_coords, 1);
if size(female_coords, 1)<=1
    femaleX = female_coords(index, 1);
    femaleY = female_coords(index, 2);
    
    femaleXOld = 0;
    femaleYOld = 0;
else
    femaleX = female_coords(index, 1);
    femaleY = female_coords(index, 2);
    
    femaleXOld = female_coords(index-1, 1);
    femaleYOld = female_coords(index-1, 2);
end    
    if femaleX<=(femaleXOld+rad) && femaleX>=(femaleXOld-rad) && femaleY<=(femaleYOld+rad) && femaleY>=(femaleYOld-rad)
        value = true;
    
    else
        value = false;
        
    end
    

end

