clear all

imgbk = imread('ped7c0000.tif');

thr = 40;
minArea = 200;

baseNum = 1350;
seqLength = 100;

% baseNum = 1374;
% seqLength = 0;
%
%imshow(imgbk);
se = strel('disk', 3);

figure;
for i=0:seqLength
    imgfr = imread(sprintf('ped7c%.4d.tif', baseNum+i));
    hold off
    %imshow(imgfr);

    imgdif = (abs(double(imgbk(:,:,1))-double(imgfr(:,:,1)))>thr) | ...
        (abs(double(imgbk(:,:,2))-double(imgfr(:,:,2)))>thr) | ...
        (abs(double(imgbk(:,:,3))-double(imgfr(:,:,3)))>thr);
    %imshow(imgdif)
    bw = imclose(imgdif, se);
    %imshow(bw)
    
    [lb num]=bwlabel(bw);
    regionProps = regionprops(lb, 'area', 'FilledImage', 'Centroid');
    inds = find([regionProps.Area]>minArea)
    

    
    hold on;
    for i=1:length(inds)
        props = regionprops(double(regionProps(inds(i)).FilledImage), 'Orientation', 'MajorAxisLength', 'MinorAxisLength');
        ellipse(props.MajorAxisLength/2, props.MinorAxisLength/2, ...
            -props.Orientation*pi/180, ...
            regionProps(inds(i)).Centroid(1), ...
            regionProps(inds(i)).Centroid(2), 'r');
        if exist('propsT')
            propsT = [propsT props];
        else
            propsT = props;
        end
    end
    drawnow
    %pause;
    
end  
    
    