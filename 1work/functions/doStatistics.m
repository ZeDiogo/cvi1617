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
    else
        time_firstCopula = 0;
    end

    %Update distances for male and female
    %if necessary for initial case 
    if size(male_coords, 1)<=1
        male_dist = 0;
        female_dist = 0;
    else
        male_dist = male_dist + sqrt(abs(MaleX - (male_coords(index-1, 1)))^2 + abs(MaleY - (male_coords(index-1, 2)))^2);
        female_dist = female_dist + sqrt(abs(FemaleX - (female_coords(index-1, 1)))^2 + abs(FemaleY - (female_coords(index-1, 2)))^2);
    end

    
end

