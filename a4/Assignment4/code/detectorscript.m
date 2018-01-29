% detection script
addpath('dpm') ;
addpath('devkit') ;

images = getData([],'test','list');
ids = images.ids(1:3);

% [DS1_cars,BS1_cars] = detector(ids{1},'detector-car',1.5,-0.2);
% [DS1_people,BS1_people] = detector(ids{1},'detector-person',1.5,-0.5);
% [DS1_bikes,BS1_bikes] = detector(ids{1},'detector-bicycle',1.5,-0.9);

% [DS2_cars,BS2_cars] = detector(ids{2},'detector-car',1.5,-0.4);
% [DS2_people,BS2_people] = detector(ids{2},'detector-person',1.5,-0.65);
% [DS2_bikes,BS2_bikes] = detector(ids{2},'detector-bicycle',1.5,-0.8);

[DS3_cars,BS3_cars] = detector(ids{3},'detector-car',1.5,0.0);
[DS3_people,BS3_people] = detector(ids{3},'detector-person',1.5,-0.5);
[DS3_bikes,BS3_bikes] = detector(ids{3},'detector-bicycle',1.5,-1.0);

% save('ds1data.mat','DS1_cars','DS1_people','DS1_bikes');
% save('ds2data.mat','DS2_cars','DS2_people','DS2_bikes');
% save('ds3data.mat','DS3_cars','DS3_people','DS3_bikes');

imdata = getData(ids{3}, 'test', 'left');
im = imdata.im;
data1 = getData([], [], 'detector-car');
datMod1 = data1.model;
data2 = getData([], [], 'detector-person');
datMod2 = data2.model;
data3 = getData([], [], 'detector-bicycle');
datMod3 = data3.model;

showboxes2(im,reduceboxes(datMod1,BS3_cars),reduceboxes(datMod2,BS3_people),reduceboxes(datMod3,BS3_bikes),'r','b','c');





