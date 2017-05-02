function [male_dist, female_dist, time_firstCopula, seenFirstCopula] = doStatistics( male_coords, female_coords, male_dist, female_dist, seenFirstCopula, frameNumber )
%DOSTATISTICS Summary of this function goes here
%   Detailed explanation goes here

    %index logic to get last coords added to male/female coords
    index = size(male_coords, 1);
    MaleX = male_coords(index, 1);
    MaleY = male_coords(index, 2);

    index = size(female_coords, 1);
    FemaleX = female_coords(index, 1);
    FemaleY = female_coords(index, 2);

    %Check for start of first copula
    if MaleX==FemaleX && MaleY==FemaleY && seenFirstCopula==false
        seenFirstCopula = true;
        %gives time for the start of first copula in seconds
        time_firstCopula = frameNumber/15;
    end

    %Update distances for male and female
    if size(male_coords, 1)<1
        male_dist = male_dist + (sqrt(MaleX^2 + MaleY^2));
        female_dist = female_dist + (sqrt(FemaleX^2 + FemaleY^2));
    else
        male_dist = male_dist + (sqrt((MaleX^2 + MaleY^2)+((male_coords(index-1, 1))^2 + (male_coords(index-1, 2))^2)));
        female_dist = female_dist + (sqrt((FemaleX^2 + FemaleY^2)+((female_coords(index-1, 1))^2 + (female_coords(index-1, 2))^2)));
    end
        
  

end

