function gauss = gaussfilt(sig,k)
    gauss = fspecial('gaussian',[1 k], sig);
end

function lapg = logfilt(sig,k)
    lapg = fspecial('log',[1 k], sig);
end

