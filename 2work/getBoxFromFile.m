function [ upLeftCornerX, upLeftCornerY, xLength, yLength ] = getBoxFromFile( fName, frameNumber )
%GETBOXFROMFILE Summary of this function goes here
%   Detailed explanation goes here


%     fileID = fopen(fName, 'r');
%     read(fileID, 1)
%     A = fscanf(fileID, '%f')
%     
%     fclose(fileID);

        fid = fopen(fName);
        A = fscanf(fid,'%d',[1,5])',
        if A(1) == frameNumber
            upLeftCornerX = A(2)
            upLeftCornerY = A(3)
            xLength = A(4)
            yLength = A(5)
        end
        fclose(fid);

end

