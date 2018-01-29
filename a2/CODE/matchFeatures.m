function [matchIndex, matchFeatDist] = matchFeatures(F1, F2, t)
    featEuclidDist = pdist2(F1,F2);
    numFeats = size(F1,1);
    matchIndex = zeros(numFeats,1);
    matchFeatDist = zeros(numFeats,2);
    for featIndex = 1:numFeats
        feat = featEuclidDist(featIndex,:);
        featSorted = sort(feat);
        featMin = featSorted(1);
        featSecondMin = featSorted(2);
        threshold = featMin / featSecondMin;
        if (threshold < t)
            minIndex = find(feat == featMin);
            matchIndex(featIndex,1) = minIndex;
            matchFeatDist(featIndex,1) = minIndex;
            matchFeatDist(featIndex,2) = featMin;
        end
    end
end


