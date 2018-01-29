figure
imshow('man.jpg')
% (x,y) -> (182,339) ; (x,y) -> (182,187)
% (x,y) -> (182,187) ; (x,y) -> (182,71)

yDiff = 339 - 187;
cmOverPixRatio = 95/yDiff;
overHorizonPix = 187 - 71;
overHorizonCM = overHorizonPix * cmOverPixRatio;
totalHeight = 95 + overHorizonCM