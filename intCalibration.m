function c_img = intCalibration(R,B_mean,D_mean,F_mean)
    % Calibrates raw image R using mean of bias images (B_mean), 
    % dark images (D_mean) and flat images (of paths: F_PATHS)
    
    
    % Checking if images are doubles
    if ~isa( R, 'double' ) 
        R = im2double(R);
    end
    if ~isa( B_mean, 'double' ) 
        B_mean = im2double(B_mean);
    end
    if ~isa( D_mean, 'double' ) 
        D_mean = im2double(D_mean);
    end
    if ~isa( F_mean, 'double' ) 
        F_mean = im2double(F_mean);
    end
    
    D_mean = D_mean - B_mean;
    F_mean = F_mean - B_mean;
    R = R - B_mean;
    
    R = R - D_mean;
    F_mean = F_mean - D_mean;
    
    F_prim = F_mean - mean2(F_mean) + 1;
    
    c_img = R./F_prim;
end