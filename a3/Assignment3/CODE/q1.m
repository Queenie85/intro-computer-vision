I = imread('shoe.jpg');
% [x, y] = getpts;

billPts = [1069 512; 1366 580; 777 981; 1163 1127];
billVPts = [0 0; 229 0; 0 500; 229 500];

% currently in [x y] mode -> if necessary, switch to [y x]

T = maketform('projective',billPts,billVPts);


hgI = imtransform(I,T,'bicubic','fill',0);

% pixel to mm ratio
mmPerPixH = 152.4/500; % dimensions of 5 bill
mmPerPixW = 69.85/229; % dimensions of 5 bill
mmPerPix = (mmPerPixH + mmPerPixW) / 2;

%figure
%imshow(hgI)
% first pt: top right
% second pt: bottom right
% third pt: bottom left
%[x, y] = getpts

shoePts = [1784 1137; 1784 1878; 1353 1878];
shoePts2 = [1784 955; 1784 1881; 1353 1881];

cmShoeHeight = (1881 - 955)*mmPerPix / 10
cmShoeWidth = (1784 - 1353)*mmPerPix / 10




