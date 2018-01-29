% q2b

% input the six image slices as grayscale

i0 = imread('mugShot.jpg');

i1 = imread('shredded/cut01.png');
i2 = imread('shredded/cut02.png');
i3 = imread('shredded/cut03.png');
i4 = imread('shredded/cut04.png');
i5 = imread('shredded/cut05.png');
i6 = imread('shredded/cut06.png');

I0 = rgb2gray(i0);

I1 = rgb2gray(i1);
I2 = rgb2gray(i2);
I3 = rgb2gray(i3);
I4 = rgb2gray(i4);
I5 = rgb2gray(i5);
I6 = rgb2gray(i6);

% store in cell array

C = {I1, I2, I3, I4, I5, I6};

% generate vector of all permutations of 1 to 6

permutations = perms([1 2 3 4 5 6]);
len = size(permutations,1);
SSD = zeros(1,7);

for (i = 1 : len)
    SSD(i,1) = 999999;
    currPermute = permutations(i,:);
    SSD(i,2:7) = currPermute;
    L = cat(2, cell2mat(C(currPermute(1))), cell2mat(C(currPermute(2))), cell2mat(C(currPermute(3))), cell2mat(C(currPermute(4))), cell2mat(C(currPermute(5))), cell2mat(C(currPermute(6))));
    [affine, matchedpts] = affineout(I0, L);
    matchNum = size(matchedpts,1);
    ssdSum = zeros(matchNum,1);
    for z = 1 : matchNum
        basePt = zeros(1,3);
        basePt(1,1:2) = matchedpts(z,1:2);
        basePt(1,3) = 1;
        matchPt = matchedpts(z,3:4);
        affinePt = affine * transpose(basePt);
        compare = cat(1,matchPt,transpose(affinePt));
        ssd = pdist(compare,'euclidean');
        ssdSum(z,1) = ssd^2;
    end
    ssdVal = sum(ssdSum);
    SSD(i,1) = ssdVal;
end

% extract minimum SSD

SSDVals = SSD(:,1);
[shortestsd, ind] = min(SSDVals);
sP = SSD(ind,2:7);
closestPermutation = cat(2, cell2mat(C(sP(1))), cell2mat(C(sP(2))), cell2mat(C(sP(3))), cell2mat(C(sP(4))), cell2mat(C(sP(5))), cell2mat(C(sP(6))));

imshow(closestPermutation);