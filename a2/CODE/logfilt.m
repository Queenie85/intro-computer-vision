function lapg = logfilt(sig,k)
    lapg = fspecial('log',[1 k], sig);
end
