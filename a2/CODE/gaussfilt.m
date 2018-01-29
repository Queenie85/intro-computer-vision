function gauss = gaussfilt(sig,k)
    gauss = fspecial('gaussian',[1 k], sig);
end


