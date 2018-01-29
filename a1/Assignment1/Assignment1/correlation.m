% q1 c

[templates, dims] = readInTemplates();
thermo = imread('thermometer.png');
imshow('thermometer.png');
drawnow;
thermo = rgb2gray(thermo);
thermo = double(thermo);
M = size(thermo,1);
N = size(thermo,2);
T = 0.70;

corrArray = zeros(M, N, 30);

for( t = 1 : 30 )
    tempo = double(rgb2gray(templates{t}));
    th = dims(t).height;
    tw = dims(t).width;
    out = normxcorr2(tempo, thermo);
    % figure, surf(out), shading flat
    offsetX = round(tw/2);
    offsetY = round(th/2);
    out = out(offsetY : offsetY + M - 1, offsetX : offsetX + N - 1);
    corrArray(:,:,t) = out; % would this work -- what dims does normxcorr output
end

[maxCorr, maxIdx] = max(corrArray,[],3); % is maxcorr from 0 to 1?
% idea:
% maxCorr is thermo.png image-sized
% maxCorr stores the maximum pixel value for that pixel from all templates
% maxIdx should store the template index for it?
[candY, candX] = find(maxCorr > T); 
% (candX, candY) gives the INDEX of the pixel value for a maxCorr pixel exceeding T
% [candX, candY] is (number of exceeding pixels) x 2 dimensions
% (candX, candY) is the INDEX of the pixel in maxCorr FOR THE IMAGE
% so to find which template its on: maxIdx(candY(i),candX(i)) where i = 0 :
% size of [candX, candY].
% we put this in an array called templateIndex
% and then we extract the correlation matrix from templateIndex

numMaxPts = size([candY, candX], 1);
templateIndex = zeros(numMaxPts, 1);

% numMaxPts holds the number of maximum points

% [candY(1), candX(1)]

for( z = 1 : numMaxPts )
    templateIndex(z) = maxIdx(candY(z), candX(z));
end

% templateIndex:
% We iterate through the max points
% For templateIndex index z, we put the template index corresponding to the
% max point (candY, candX) by the index of the [candX, candY] value
% templateIndex contains numMaxPts values
% each value corresponds to a max point exceeding the threshold
% each value is the template index number that the max point was from

% thisCorr = corrArray(:,:,templateIndex); % does this work out???

% this gives us the original corrArray but
% instead of 30 dimensions, its ...

for ( x = 1 : numMaxPts )
    thisCorr = corrArray(:,:,templateIndex(x));
    % this should give us the corrArray for a specific template
    % now we have: the thisCorr image correlated with the template
    % candidate
    % we also have the coordinates of the max points:
    %(candY(x), candX(x))
    % so we have to check if it is a max in a 3 x 3 box.
    % If true, we draw a box around it (which shouldn't be bad).
    % Repeat this for every max point.
    row = candY(x);
    col = candX(x);
    if isLocalMaximum(col,row,thisCorr) == 1
        % draw bounding box
        tInd = templateIndex(x);
        drawAndLabelBox(col,row,tInd,dims)
    end
end














