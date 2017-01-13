clc;
clear all;
close all;
%Init MatConvNnet

run /usr/local/matconvnet-1.0-beta23/matlab/vl_setupnn

%Chargement du modèle
net=load('/usr/local/imagenet/imagenet-vgg-f.mat');
net=vl_simplenn_tidy(net)
vl_simplenn_display(net,'inputSize', [224  224 3 1])

% Charger et préparer l'image
im = imread('basile_tunning.jpg');
im_ = single(im) ; %Note:valeurs entre 0 et 255
im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
im_ = im_ - net.meta.normalization.averageImage;

%Calculer la prédiction 
res = vl_simplenn(net, im_);

%Afficher la classe prédite 
scores = squeeze(gather(res(6).x));
[bestScore , best] = max(scores);
%figure(2); 
%clf; 
%imagesc(im);
%print(size(res(1).x,1))
%[n,m,j]=size(res(5).x)
for i=1:4
    subplot(2,2,i);
    imshow(res(6).x(:,:,i+4))
end

%colormap autumn
title(sprintf('%s(%d),score%.3f',...
   net.meta.classes.description{best}, best , bestScore));