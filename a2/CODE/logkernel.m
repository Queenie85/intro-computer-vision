% logsep func

function kern = logkernel(sig, tolerance)
    kern = fspecial('log',tolerance,sig);
end



