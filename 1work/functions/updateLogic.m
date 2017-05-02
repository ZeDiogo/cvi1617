function [male_coordsR, female_coordsR, flagTouchR, flagCoupleR, pos, areas, sizeDect] = updateLogic ( imgfr, male_coords, female_coords, flagTouch, flagCouple )
%UPDATE Summary of this function goes here
%   Detailed explanation goes here


%function [pos area] = update( male_coords, female_coords )

    %----------------------------
%imgfr = imread(sprintf('./frames/scene%.5d.png',3));
    %----------------------------

    [pos, areas, sizeDect] = detectObject(imgfr);
    
    if flagTouch == true
        %return true if merge occurs and false if split occurs
        if detectMerge(pos, areas) == true
            flagCouple = true;
        else
            flagCouple = false;
        end
    end

    if flagCouple == true
        [~, idx] = max(areas);
        male_coords = [male_coords; pos(idx, :)];
        female_coords = [female_coords; pos(idx, :)];
    else
        %detectGender(pos areas);
        %------------------------------------------
        %get and save female pos
        [~, idx] = max(areas);
        female_coords = [female_coords; pos(idx, :)];
        %remove female area to be able to detect male
        areas(idx) = 0;
        %get and save male pos
        [~, idx] = max(areas);
        male_coords = [male_coords; pos(idx, :)];
        %------------------------------------------
    end
    
    flagTouch = detectTouch(pos, areas);

    %return values
    male_coordsR = male_coords;
    female_coordsR = female_coords;
    flagTouchR = flagTouch;
    flagCoupleR = flagCouple;
    
end

