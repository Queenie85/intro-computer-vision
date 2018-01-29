% sift to output affines

function [A, allMatchedPts] = affineout(I1, I2)
    I1 = single(I1);
    I2 = single(I2);
    
    [keypts1, desc1] = vl_sift(I1);
    [keypts2, desc2] = vl_sift(I2);
    
    k1 = transpose(keypts1);
    k2 = transpose(keypts2);
    
    d1 = transpose(desc1);
    d2 = transpose(desc2);
    
    [matchedIndices, matchedFeatDistances] = matchFeatures(d1, d2, 0.8);
    mIsize = size(matchedIndices,1);
    
    matchedSize = size(find(matchedIndices > 0));
    matchedNumber = matchedSize(1,1);

    matchedPts1 = zeros(matchedNumber, 2);
    matchedPts2 = zeros(matchedNumber, 2);

    matchedWithDistances = zeros(1,5);
    
    j = 1;
    for i = 1:mIsize
        currIndex = matchedIndices(i);
        if (currIndex > 0)
            matchedPts1(j,:) = k1(i,1:2);
            matchedPts2(j,:) = k2(currIndex,1:2);
            matchedWithDistances(j,1:2) = k1(i,1:2);
            matchedWithDistances(j,3:4) = k2(currIndex,1:2);
            matchedWithDistances(j,5) = matchedFeatDistances(i,2);
            j = j + 1;
        end
    end
    
    affines = findAffineTransform(matchedWithDistances, 5);
    
    A = zeros(2,3);
    
    A(1,1) = affines(1,1); % a
    A(1,2) = affines(2,1); % b
    A(1,3) = affines(5,1); % e
    A(2,1) = affines(3,1); % c
    A(2,2) = affines(4,1); % d
    A(2,3) = affines(6,1); % f
    
    allMatchedPts = matchedWithDistances(:,1:4);
    
end

