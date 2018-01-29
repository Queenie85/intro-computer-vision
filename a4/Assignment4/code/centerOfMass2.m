% 3dcenter

function [center, worldCubes] = centerOfMass2(cameraCalib, imData, imDepth)
    % load f, px, py from cameraCalib
    
    % load the imData of the specific objClass as a matrix
    % note: objClass as a separate argument here may be unnecessary
    
    % iterate through each row of imData
    % the four box bound points: 
    % > (x_l, y_t) (x_l, y_b) (x_r, y_t) (x_r, y_b)
    % > in indices of the row (0..5): (0,1) (0,3) (2,1) (2,3) % flip to
    % (y,x)
    % get the entries bound by these indices as a submatrix
    % > repmat vertical stack for x's, horizontal stack for y's
    % get the corresponding depth pixels from imDepth as a submatrix
    % elementwise subtract each entry by px, divide by f, multiply by depth
    % elementwise subtract each entry by py, divide by f, multiply by depth
    % will give world coordinates
    
    f = cameraCalib.f;
    k = cameraCalib.K;
    px = k(1,3);
    py = k(2,3);
    
    numRows = size(imData,1);
    
    center = zeros(numRows,3);
    worldCubes = {1,numRows};
    
    for i = 1:numRows
        box = imData(i,:);
        xL = round(box(1)); xR = round(box(3)); yT = round(box(2)); yB = round(box(4));
        if (xR >= size(imDepth,2))
            xR = xR - 4;
        end
        [~,~,tl] = KRt_from_P(cameraCalib.P_left);
        xRow = xL:xR; yCol = (yT:yB)';
        width = size(xRow,2); height = size(yCol,1);
        xMid = xL + round(width/2); yMid = yT + round(height/2);
        zMid = imDepth(yMid, xMid);
        
        xW = zMid * ((xMid - px) / f);
        yW = zMid * ((yMid - py) / f);
        zW = zMid;
        xw = xW - tl(1) ; yw = yW - tl(2); zw = zW - tl(3);
        center(i,:) = [xw yw zw];
        
        xMat = repmat(xRow,height,1); yMat = repmat(yCol,1,width);
        depthChunk = imDepth(yT:yB,xL:xR);

        xMatpx = xMat - px;
        yMatpy = yMat - py;
        xMatd = xMatpx ./ f;
        yMatd = yMatpy ./ f;
        camX = depthChunk .* xMatd;
        camY = depthChunk .* yMatd;
        % need to do a translation into world coordinates!
        % then we find the mean of all (X,Y,Z) world points / num of pts
        worldCube = zeros(height, width, 3);
        worldCube(:,:,1) = camX; % X
        worldCube(:,:,2) = camY; % Y
        worldCube(:,:,3) = depthChunk; % Z
        
        % translation edit:
        
        worldCube(:,:,1) = worldCube(:,:,1) - tl(1);
        worldCube(:,:,2) = worldCube(:,:,2) - tl(2);
        worldCube(:,:,3) = worldCube(:,:,3) - tl(3);
        
        
        
        worldCubes{i} = worldCube;
    end

end