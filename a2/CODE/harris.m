% MISC VARIABLES

sig = 1;
r = 1;
shape = 2*r+1;
t = 100;
a = 0.04;
wfilt = 6;
gw = fspecial('gaussian', max(1, fix(wfilt*sig)), sig);
cdm = fspecial('disk',r)>0;

% STEP 0: Read image, convert to grayscale

buildbase = imread('building.jpg');
build = rgb2gray(buildbase);

% STEP 1: Get x and y directional gradients of image 

[Ix, Iy] = imgradientxy(build, 'prewitt');

% elementwise multiplication for moment 
Ix2 = Ix.^2; 
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

GIx2 = conv2(Ix2, gw, 'same');
GIy2 = conv2(Iy2, gw, 'same');
GIxy = conv2(Ixy, gw, 'same');

% determinant and trace

detM = GIx2 .* GIy2 - GIxy.^2;
trM = GIx2 + GIy2 + eps;

% harris measure

R2 = detM - a * trM.^2;
R2=(1000/max(max(R2)))*R2;
R=R2;

% R = detM ./ trM;


% non-maxima suppression

maxes = ordfilt2(R, shape^2, cdm);

% harris points:
Rt = R > t;
hp = (R == maxes) & (R > t);

[r,c] = find(hp);

figure, imshow(hp);


figure, image(buildbase), hold on,
plot(c, r, 'ro'), title('harris corners');

