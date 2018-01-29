% sift

I10 = imread('book.jpg');
I20 = imread('findBook.jpg');

I1 = single(rgb2gray(I10));
I2 = single(rgb2gray(I20));

[keypoints1, descriptors1] = vl_sift(I1);
[keypoints2, descriptors2] = vl_sift(I2);

figure; imshow(I10); hold on;
h1 = vl_plotframe(keypoints1) ;
h2 = vl_plotframe(keypoints1) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

figure; imshow(I20); hold on;
h1 = vl_plotframe(keypoints2) ;
h2 = vl_plotframe(keypoints2) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

k1 = transpose(keypoints1);
k2 = transpose(keypoints2);

d1 = transpose(descriptors1);
d2 = transpose(descriptors2);

[matchedIndices, matchedFeatDistances] = matchFeatures(d1, d2, 0.8);
mIsize = size(matchedIndices,1);

% matchedFeatDistances - an M x 3 matrix where
% col 1 = points 1, col 2 = points 2, col 3 = their feature distance

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

% figure; ax = axes;
% showMatchedFeatures(I10,I20,matchedPts1,matchedPts2,'montage','Parent',ax);
% title(ax, 'Candidate point matches');
% legend(ax, 'Matched points 1','Matched points 2');

affines = findAffineTransform(matchedWithDistances, 5);

A = zeros(2,3); % our affine transformation matrix

A(1,1) = affines(1,1); % a
A(1,2) = affines(2,1); % b
A(1,3) = affines(5,1); % e
A(2,1) = affines(3,1); % c
A(2,2) = affines(4,1); % d
A(2,3) = affines(6,1); % f

maxY = size(I1,2); % 320
maxX = size(I1,1); % 499

c1 = [1 1 1];
c2 = [maxY 1 1]; % (1,320)
c3 = [1 maxX 1]; % (499, 1)
c4 = [maxY maxX 1]; % (499, 320)

cornersBase = zeros(4,2);
cornersTrfm = zeros(4,2);

cornersBase(1,:) = c1(1:2);
cornersBase(2,:) = c2(1:2);
cornersBase(3,:) = c3(1:2);
cornersBase(4,:) = c4(1:2);

c1 = transpose(c1);
c2 = transpose(c2);
c3 = transpose(c3);
c4 = transpose(c4);

cT1 = A * c1;
cT2 = A * c2;
cT3 = A * c3;
cT4 = A * c4;

cx1 = transpose(cT1);
cx2 = transpose(cT2);
cx3 = transpose(cT3);
cx4 = transpose(cT4);

cornersTrfm(1,:) = cx1;
cornersTrfm(2,:) = cx2;
cornersTrfm(3,:) = cx3;
cornersTrfm(4,:) = cx4;

figure; ax = axes;
showMatchedFeatures(I10,I20,cornersBase,cornersTrfm,'montage','Parent',ax);
title(ax, 'Affine corner matches');
legend(ax, 'Matched points 1','Matched points 2');

figure; ax = axes;
imshow(I20); hold on;
plot([cornersTrfm(1,1) cornersTrfm(2,1)], [cornersTrfm(1,2) cornersTrfm(2,2)],'g','LineWidth',3);
plot([cornersTrfm(1,1) cornersTrfm(3,1)], [cornersTrfm(1,2) cornersTrfm(3,2)],'g','LineWidth',3);
plot([cornersTrfm(3,1) cornersTrfm(4,1)], [cornersTrfm(3,2) cornersTrfm(4,2)],'g','LineWidth',3);
plot([cornersTrfm(2,1) cornersTrfm(4,1)], [cornersTrfm(2,2) cornersTrfm(4,2)],'g','LineWidth',3);
title(ax, 'Affine boundary');






















