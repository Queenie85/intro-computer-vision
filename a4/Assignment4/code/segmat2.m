% segmentation matrix calculation

function segOut = segmat(centroid, matCubeCells, imData, i, segMatrix, thresh)
    numDetects = size(imData,1);
    
    for j = 1:numDetects
        box = imData(j,:);
        xL = round(box(1)); xR = round(box(3)); yT = round(box(2)); yB = round(box(4));
        if (xR >= 1242)
            xR = xR - 4;
        end
        matCube = matCubeCells{j};
        matCubeX = matCube(:,:,1); matCubeY = matCube(:,:,2); matCubeZ = matCube(:,:,3);
        % matCubeX = matCubeX - centroid(1); matCubeX = matCubeX .^ 2;
        % matCubeY = matCubeY - centroid(2); matCubeY = matCubeY .^ 2;
        matCubeZ = matCubeZ - centroid(3); matCubeZ = matCubeZ .^ 2;
        distVal = matCubeZ;
        dists = sqrt(distVal);
        isSegment = dists <= thresh;
        b = zeros(size(matCubeX,1),size(matCubeX,2));
        b(isSegment) = i;
        segMatrix(yT:yB,xL:xR) = b; 
    end
    segOut = segMatrix;
end


