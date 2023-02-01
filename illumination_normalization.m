function normalized_image = illumination_normalization(image, ~)
    Linear = rgb2lin(image);
    ill = illumpca(Linear);
    OutImage = chromadapt(Linear, ill, 'ColorSpace','linear-rgb');
    normalized_image = lin2rgb(OutImage);
end