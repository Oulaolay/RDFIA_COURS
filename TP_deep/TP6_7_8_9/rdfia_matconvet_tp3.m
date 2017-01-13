clc;
clear all;
close all;
%Init MatConvNnet

run /usr/local/matconvnet-1.0-beta23/matlab/vl_setupnn
path_scene='15SceneSplit.mat'
load(path_scene)

%Chargement du modèle
net=load('/usr/local/imagenet/imagenet-vgg-f.mat');
net=vl_simplenn_tidy(net)
vl_simplenn_display(net,'inputSize', [224  224 3 1])


%% Generation des descripteurs (feature extraction)
X_train = zeros(size(X_train_path,1),4096);
X_test= zeros(size(X_test_path,1),4096);

% Base de train
for i=1:size(X_train_path,1)
    % Charger et préparer l'image
    im = imread(strjoin(X_train_path(i)));
    im=repmat(im,1,1,3);
    im_ = single(im); %Note:valeurs entre 0 et 255
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
    im_ = im_ - net.meta.normalization.averageImage;

    %Calculer le descripteur
    res = vl_simplenn(net, im_);
    features = squeeze(res(20).x);
    features=features/norm(features);
    X_train(i,:)=features;    
end

% Base de Test
for i=1:size(X_test_path,1)
 % Charger et préparer l'image
    im = imread(strjoin(X_test_path(i)));
    im=repmat(im,1,1,3);
    im_ = single(im); %Note:valeurs entre 0 et 255
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
    im_ = im_ - net.meta.normalization.averageImage;

    %Calculer le descripteur
    res = vl_simplenn(net, im_);
    features = squeeze(res(20).x);
    features=features/norm(features);
    X_test(i,:)=features;
end        


%% Apprentissage des SVMs
C=100
model = train_classifier(X_train, y_train, C);
[y_hat, Y_hat_scores] = predict_classifier(model, X_test);

acc = zeros(15,1);
total_items = zeros(15,1);
for i=1:size(X_test_path,1)
    total_items(y_test(i)) = total_items(y_test(i)) + 1;
    acc(y_test(i)) = acc(y_test(i)) + (y_hat(i) == y_test(i));
end
acc = acc./total_items;