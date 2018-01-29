% logsep

% brute force:

sig1 = 1.0;
sig2 = 5.0;
sig3 = 10.0;

kernel1 = fspecial('log', 3, sig3);
kernel2 = fspecial('log', 5, sig3);
kernel3 = fspecial('log', 7, sig3);
kernel4 = fspecial('log', 9, sig3);

[U1,S1,V1] = svd(kernel1);
[U2,S2,V2] = svd(kernel2);
[U3,S3,V3] = svd(kernel3);
[U4,S4,V4] = svd(kernel4);


% sig1
% S1: 0.3101 and 0.2030
% S2: 0.3856, 0.1260, 0.0013
% S3: 0.3872, 0.1052, 0.0003
% S4: 0.3871, 0.1045

% sig2
% S1: (1.0 x e-03) * 0.5022, 0.4951
% S2: 0.0010, 0.0010
% S3: 0.0015, 0.0014
% S4: 0.0019, 0.0016

% sig3
% S1: (1.0e-04) * 0.3142, 0.3131
% S2: (1.0e-04) * 0.6658, 0.6574
% S3: (1.0e-04) * 0.9770, 0.9519
% S4: (1.0e-03) * 0.1270, 0.1216

% no separability!

log = logfilt(1.55, 99); % s = 1.55
g1 = gaussfilt(2.0, 99); % s = 2.0
g2 = gaussfilt(1.0, 99); % s = 1.0
dog = g1 - g2;

figure; ax = axes; hold on;
plot(log, 'r');
plot(dog, 'g');
title(ax, 'LoG compared to DoG');
legend(ax, 'LoG', 'DoG');




