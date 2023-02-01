function ROI = image_cropping(image)
    I = rgb2gray(image);
    BW = imbinarize(I);
    BW = 1 - BW;
    s = regionprops(BW,'basic');
    max_box = s(s.Area == max(s.Area)).BoundingBox;
    xMin = ceil(max_box(1));
    xMax = xMin + max_box(3) - 1;
    yMin = ceil(max_box(2));
    yMax = yMin + max_box(4) - 1;
    ROI = image(yMin:yMax,xMin:xMax,:);
end