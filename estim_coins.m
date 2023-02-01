
function [coins] = estim_coins(measurement,bias,dark,flat)

% [coins] = estim_coins(measurement,bias,dark,flat)
% This function detects euro coins in an image measurement and counts the 
% number of occurrence of each of the following coins 5,10,20 and 50 cents,
% 1 and 2 euro.
% The output coins is an 1x6 array such that each element represents the 
% number of coins detected in measurement in order mentioned above.  
% The inputs of the function respectively represent the image where the 
% coins are detected), the mean of bias images, the mean of dark images 
% and the mean of flat images.
% First of all the intensity of the measurement is calibrated, then the 
% calibrated image is illumninated. Afterwards a geometric calibration is
% applied to the illuminated image to convert the horizontal and vertical 
% domains from pixel to mm.
% Morphological structuring of the binarized image and the hough transform 
% algorithm (matlab built-in function (image processing toolbox))were used 
% to detect the coins.
% To count the occurrence of a coin in an image, pairewise distances are 
% calculated based on the true measurements of each coin and the estimated
% measurements. A coin belongs to one of the six classes if it has the 
% samllest distance to the true measurement of that class.

% Intensity calibration of the measurement

imCal=intCalibration(measurement,bias,dark,flat);

% Illumination

imIll=illumination_normalization(imCal);

% Geometric Calibration

[hpx2mm, vpx2mm]=geoCalibration(imIll);
geoCal=imresize(imCal,[hpx2mm, vpx2mm]);

% Binarization 

imgray=rgb2gray(geoCal);

level=graythresh(imgray);

bw=imbinarize(imgray,'adaptive','Sensitivity',level,'ForegroundPolarity','dark');


% Morphological structuring 

bw=imcomplement(bw);

se=strel('disk',10,0);

bw=imclose(bw,se);

% Min radius and max radius of the coins have estimated from the radii of 
% the geo properties (using regionprops). It could be known from the griund
% truth measurementS of the coins. We choose to consider a large range.

Rmin = 15;
Rmax = 30;
  
% Find all the bright circles in the image and their radii are estimated


[centersBright, radiiBright] = imfindcircles(bw,[Rmin Rmax], ...
                                        'ObjectPolarity','bright','Sensitivity',0.90, 'EdgeThreshold',level);

                                    
% coinTrue is an array containing true measurement for each of the 6 coins
% in millimeter.
% The order is 5c, 10c, 20c, 50c, 1e, 2e

coinTrue=[21.25,18.95,22.25,24.25,23.25,25.75]';


% Pairewise distances between estimated diameters and the true diameters   
 % id contains the index of the shortest distances. 

[~,id]=pdist2(coinTrue,radiiBright, 'euclidean','Smallest',1);


% Create an array with 0s and size 6. We count the coins based on id
% array. The size of the id array corressponds to the number of coins
% detected on the image. For instance, if the output of id is [1,3,3,6],
% then this meaans 4 coins have been detected such that the algorithm
% estimates 1 (5c) coin, 2 (20c) coins and 1 (2e) coin. We are counting the
% number of occurence of an index in the index array id.

coins=zeros(1,6);

for k=1:length(id)
   cc=id(k);
   coins(cc)=coins(cc)+1;
end


end



