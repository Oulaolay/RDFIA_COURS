clear all;
close all;
s= 16;
delta = 8;
%%% Dessins des patchs sur l'image 
I = imread('../scene_test/bedroom/image_0003.jpg');
%I = imread('../scene_test/MITcoast/image_0015.jpg');
%I = imread('../scene_test/MITcoast/image_0016.jpg')
% CALCUL DES SIFTs 
[ sifts,r] = computeSIFTsImage(I,s,delta);
drawPatches(I,r,s,sifts);
% STOCKAGE DES SIFTs en unit8
sifts=uint8(sifts*255);

desname = '../descriptors3_test/bedroom/image_0003.mat';
%desname = '../descriptors3_test/MITcoast/image_0016.mat';
save(desname,'sifts');






















