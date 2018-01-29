% depth calculation

function depth = depth(image, imset)
    cameraParams = getData(image, imset, 'calib');
    disp = getDisparity(imset, image); % returns the n x m disparity mat
    focal = cameraParams.f;
    base = cameraParams.baseline;
    
    dispInv = 1./disp;
    numerator = focal * base;
    depth = numerator.*dispInv;
end

