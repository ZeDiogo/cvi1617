function [male_coords, female_coords, flagTouch, flagCouple, pos, areas, sizeDect] = updateLogic ( imgfr, male_coords, female_coords, flagTouch, flagCouple )
%UPDATE Summary of this function goes here
%   Detailed explanation goes here


%function [pos area] = update( male_coords, female_coords )

    %----------------------------
%imgfr = imread(sprintf('./frames/scene%.5d.png',3));
    %----------------------------

    [pos, areas, sizeDect] = detectObject(imgfr);
    
    if flagTouch == true
        %return true if merge occurs and false if split occurs
        %-------------Código para as key frames--------------------%
        %imshow(imgfr);
        %----------------------------------------------------------%
        if detectMerge(pos, areas) == true
            flagCouple = true;
        %-------------Código para as key frames--------------------%
        %imshow(imgfr);
        %----------------------------------------------------------%
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
        [sizeFemale, idFemale] = max(areas);
        %FIXME
        female_coords = [female_coords; pos(idFemale, :)];
        %remove female area to be able to detect male
        tmpFemale = sizeFemale; 
        areas(idFemale) = 0;
        %get and save male pos
        [~, idMale] = max(areas);
        %FIXME confirm it's a male using last postion
        male_coords = [male_coords; pos(idMale, :)];
        areas(idFemale) = tmpFemale;
        %------------------------------------------
    end
    
    
    flagTouch = detectTouch(pos, areas);
    
   
    
end

