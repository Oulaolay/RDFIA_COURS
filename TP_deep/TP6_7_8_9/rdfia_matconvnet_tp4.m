run /usr/local/matconvnet-1.0-beta23/matlab/vl_setupnn;
path_scene='15SceneSplit.mat';
load(path_scene);

[ntrain, ~] = size(X_train_path);
[ntest, ~] = size(X_test_path);
nImages = ntrain + ntest;

imdb.images = struct;
imdb.images.data=zeros(64,64,1,nImages,'single');
imdb.images.labels=zeros(1,nImages,'single');
imdb.images.set=zeros(1,nImages,'uint8');

mean = zeros(64,64);
var= zeros(64,64);
for i=1:ntrain
    im = imread(strjoin(X_train_path(i)));
    im_ = single(im); %Note:valeurs entre 0 et 255
    im_ = imresize(im_, [64,64]);
    mean=mean+im_;
    %mean_2=mean_2+im_.*im_
end
mean = mean/ntrain;

for i=1:ntrain
    im = imread(strjoin(X_train_path(i)));
    im_ = single(im); %Note:valeurs entre 0 et 255
    im_ = imresize(im_, [64,64]);
    imdb.images.data(:,:,i) = im_- mean;
    
    imdb.images.labels(i) = y_train(i);
    imdb.images.set(i) = 1;
end

for i=1:ntest
    im = imread(strjoin(X_test_path(i)));
    im_ = single(im); %Note:valeurs entre 0 et 255
    im_ = imresize(im_, [64,64]);
    imdb.images.data(:,:,i+ntrain) = im_ - mean;
    
    imdb.images.labels(i+ntrain) = y_test(i);
    imdb.images.set(i+ntrain) = 2;
end

net = struct;
net.layers={};
net.layers{end+1} = struct('name','conv1', ...
                           'type','conv', ...
                           'weights',{{0.01*randn(9,9,1,10,'single'),zeros(1,10,'single')}}, ...
                           'stride',1, ...
                           'pad',0);
                       
net.layers{end+1} = struct('name','pool1', ...
                           'type','pool', ...
                           'method','max', ...
                           'pool',[7 7], ...
                           'stride',7, ...
                           'pad',0);
                       
net.layers{end+1} = struct('name','relu1', ...
                           'type'   ,'relu');
                       
 net.layers{end+1} = struct('name','drop1', ...
                           'type','dropout', ...
                           'rate', 0.5);
                       
net.layers{end+1} = struct('name','fc2', ...
                           'type','conv', ...
                           'weights',{{0.01*randn(8,8,10,15,'single'),zeros(1,15,'single')}}, ...
                           'stride',1, ...
                           'pad',0);      
net.layers{end+1}=struct('name','Loss', ...
                        'type','softmaxloss');
    
net=vl_simplenn_tidy(net);
opts=struct;
opts.batchSize=50;
opts.learningRate=0.0001;
opts.numEpochs=500;
opts.expDir='exp/';
opts.continue=false;


%Train  Test
[net,info]=cnn_train(net,imdb,@getBatch, ...
        opts, ...
        'val',find(imdb.images.set==2));


                           
                       