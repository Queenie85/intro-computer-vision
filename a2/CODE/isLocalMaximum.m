function truth = isLocalMaximum(x, y, thisCorr)
    val = thisCorr(y,x);
    truth = 1;
    for (i = y-1 : y+1)
        for (j = x-1 : x+1)
            if and(i ~= 0, j ~= 0)
                if and(thisCorr(i,j) >= val, or(i ~= y, j ~= x))
                    truth = 0; % not a local maximum
                end
            end
        end
    end
    
end
