% com calculation

largeMax = 9999;

images = getData([],'test','list');
ids = images.ids(1:3);

depthImg1 = depth(ids{1},'test');
depthImg2 = depth(ids{2},'test');
depthImg3 = depth(ids{3},'test');

infs1 = find(depthImg1==Inf);
infs2 = find(depthImg2==Inf);
infs3 = find(depthImg3==Inf);

depthImg1(infs1) = max(max(depthImg1))+5;
depthImg2(infs2) = max(max(depthImg2))+5;
depthImg3(infs3) = max(max(depthImg3))+5;

ccD1 = getData(ids{1},'test','calib');
ccD2 = getData(ids{2},'test','calib');
ccD3 = getData(ids{3},'test','calib');

load('ds1data.mat');
load('ds2data.mat');
load('ds3data.mat');

[D1centCar,D1Car] = centerOfMass(ccD1, DS1_cars, depthImg1);
[D1centPpl,D1Ppl] = centerOfMass(ccD1, DS1_people, depthImg1);
[D1centBike,D1Bike] = centerOfMass(ccD1, DS1_bikes, depthImg1);
 
[D2centCar,D2Car] = centerOfMass(ccD2, DS2_cars, depthImg2);
[D2centPpl,D2Ppl] = centerOfMass(ccD2, DS2_people, depthImg2);
[D2centBike,D2Bike] = centerOfMass(ccD2, DS2_bikes, depthImg2);

[D3centCar,D3Car] = centerOfMass(ccD3, DS3_cars, depthImg3);
[D3centPpl,D3Ppl] = centerOfMass(ccD3, DS3_people, depthImg3);
[D3centBike,D3Bike] = centerOfMass(ccD3, DS3_bikes, depthImg3);

save('D1COM.mat','D1centCar','D1centPpl','D1centBike');
save('D2COM.mat','D2centCar','D2centPpl','D2centBike');
save('D3COM.mat','D3centCar','D3centPpl','D3centBike');

save('D1WM.mat','D1Car','D1Ppl','D1Bike');
save('D2WM.mat','D2Car','D2Ppl','D2Bike');
save('D3WM.mat','D3Car','D3Ppl','D3Bike');

