img = imread('synthetic.png');
img = double(img);
img = mean(img,3);

imgS = img; 
cnt = 1;
clear responseLoG
k = 1.1;
sigma = 2.0;
s = k.^(1:30)*sigma;
maxes = zeros(size(img,1),size(img,2),length(s));
responseLoG = zeros(size(img,1),size(img,2),length(s));

T = 60.00;

for si = 1:length(s)
    sL = s(si); % grab the sigma value at scale # si
    hs = max(25,min(floor(sL*3),128)); % laplacian of gaussian kernel size
    HL = fspecial('log',[hs hs],sL); % laplacian of gaussian filter
    imgFiltL = conv2(imgS,HL,'same'); % convolve the image with the laplacian of gaussian
    %Compute the LoG
    responseLoG(:,:,si) = abs((sL^2)*imgFiltL); % normalize the result and store in responseLoG at layer si 
    % edit - we used the abs() here because we are looking at the maximum
    % magnitude of the LoG -- will this work?
end
fg = figure;imagesc(img);axis image;hold on;colormap gray;
drawnow;

% find local maxima at each scale

% for scale = 1:length(s)
%     maxes_logic = imregionalmax(responseLoG(:,:,scale));
%     maxes(:,:,scale) = maxes_logic;
% end
% 
% sustained = ones(size(img,1),size(img,2));
% for sk = 1:length(s)
%     sustained = sustained & maxes(:,:,sk);
% end
% 
% imshow(sustained)
% 
% baseLayer = responseLoG(:,:,1);
% for x = 1:size(im,1)
%     for y = 1:size(img,1)
%         if isLocalMaximum(x,y,baseLayer) == 1
%             
%         end
%     end
% end

%
%
% tried to grab A1 code and repeat it here
%
% % %
% %
%

[maxValues, maxAtThisScale] = max(responseLoG, [], 3);
% goes through responseLoG 3D matrix
% outputs 2 (m x n) matrices

% maxValues -> at each pixel of the image (x,y), is the maximum value
% among all possible scales
% maxAtThiScale -> at each pixel of the image (x,y), is the scale at which 
% the maximum value was found

[candY, candX] = find(maxValues > T);
numMaxPts = size([candY, candX], 1);
scaleLocation = zeros(numMaxPts, 1);

% [candY, candX] are two arrays that respectively output the 
% y and x coordinate of all the max values greater than threshold T
% the number of max points is the number of elements in candY (or candX)
% scaleLocation is going to be the scale each max pt is found

for z = 1 : numMaxPts
    scaleLocation(z) = maxAtThisScale(candY(z), candX(z));
end

% go through every max point
% put in the scaleLocation array for that max point, 
% the scale that the particular max was found


for currMaxPt = 1 : numMaxPts
    % for each max point
    currentScaleLayer = responseLoG(:,:,scaleLocation(currMaxPt));
    % get the LoG image for the max point's scale
    row = candY(currMaxPt);
    col = candX(currMaxPt);
    % get the coordinates of the max point
    if isLocalMaximum(col,row,currentScaleLayer) == 1
        % if the point is NOT a local maxium ...
        scaleValue = s(scaleLocation(currMaxPt));
        %scaleValue = sqrt(2) * scaleValue;
        % get the scale value from the s array
        % multiply it by sqrt(2) as based in the slides
        xc = scaleValue*sin(0:0.1:2*pi)+col;
        yc = scaleValue*cos(0:0.1:2*pi)+row;
        plot(xc,yc,'r');
        drawnow;
        % draw the circle
    end
end




