function A = findAffineTransform(matchedPoints, k)
    matchedPointsSorted = sortrows(matchedPoints,5);
    kCorrespondences = matchedPointsSorted(1:k,:);
    
    P = zeros(k*2,6);
    Pht = zeros(k*2,1);
    
    j = 1;
    for i = 1:k*2
        if (mod(i,2) ~= 0)
            P(i,1:2) = kCorrespondences(j,1:2);
            P(i,5:6) = [1 0];
            P(i+1,3:4) = kCorrespondences(j,1:2);
            P(i+1,5:6) = [0 1];
            Pht(i,1) = kCorrespondences(j,3);
            Pht(i+1,1) = kCorrespondences(j,4);
            j = j + 1;
        end
    end
    
    Pt = transpose(P);
    PInv = pinv(Pt * P);
    PRight = Pt * Pht;
    A = PInv * PRight;
    
end

