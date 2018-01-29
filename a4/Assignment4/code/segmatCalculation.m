% segmentation matrix chunks

load('ds1data.mat');
load('ds2data.mat');
load('ds3data.mat');

load('D1COM2.mat'); load('D1WM2.mat');
load('D2COM2.mat'); load('D2WM2.mat');
load('D3COM2.mat'); load('D3WM2.mat');

segM1 = zeros(375,1242);
segM2 = zeros(375,1242);
segM3 = zeros(375,1242);

DS1segCars = segmat2(D1centCar,D1Car,DS1_cars,10,segM1,50);
DS1segPpl = segmat2(D1centPpl,D1Ppl,DS1_people,30,segM1,10);
DS1segBikes = segmat2(D1centBike,D1Bike,DS1_bikes,1000,segM1,5);

DS1Segs = DS1segCars + DS1segPpl + DS1segBikes;

DS2segCars = segmat2(D2centCar,D2Car,DS2_cars,10,segM2,50);
DS2segPpl = segmat2(D2centPpl,D2Ppl,DS2_people,30,segM2,50);
DS2segBikes = segmat2(D2centBike,D2Bike,DS2_bikes,60,segM2,2);

DS2Segs = DS2segCars + DS2segPpl + DS2segBikes;

DS3segCars = segmat2(D3centCar,D3Car,DS3_cars,10,segM3,30);
DS3segPpl = segmat2(D3centPpl,D3Ppl,DS3_people,30,segM3,3);
DS3segBikes = segmat2(D3centBike,D3Bike,DS3_bikes,60,segM3,3);

DS3Segs = DS3segCars + DS3segPpl + DS3segBikes;

image(DS3Segs)



