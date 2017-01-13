
clear;

%% Chargement des données
load('circles.mat');

% On transforme les données en données centrées réduites
moys = mean([Xtrain;Xtest]);
variance = std([Xtrain;Xtest]);
Xtrain = (Xtrain - moys)./variance;
Xtest = (Xtest - moys)./variance;

% pour visualiser les données
%figure(1);
%plot(Xtrain(1:100,1),Xtrain(1:100,2),'b.');
%hold on;
%plot(Xtrain(101:200,1),Xtrain(101:200,2),'r.');
%hold off;

%% Propagation, évaluation de l'erreur et rétro-propagation
% hyperparamètres
nb_epoch = 500;
nh = 10;
eta = 5;
batch_size = 50; % Must be diviseur de 200

% initialisation du réseau de neurones
mynet = initMLP(2,nh,2);

[npoints, ~] = size(Xtrain);
loss_index_train = 1;

for i=1:nb_epoch
    
    iterator = 1;
    permutations = randperm(npoints);
    
    % Stockage de l'erreur sur tout le set d'apprentissage pour affichage
    [yhat, out] = forward(mynet, Xtrain);
    [L, acc] = loss_accuracy(yhat, Ytrain);        
    losses_train(loss_index_train) = mean(L);
    loss_index_train = loss_index_train + 1;
    
    for j = 1:npoints/batch_size
        
        % Construction du mini-batch
        x_batch = Xtrain(permutations(iterator:iterator+batch_size-1),:);
        y_batch = Ytrain(permutations(iterator:iterator+batch_size-1),:);
        iterator = iterator + batch_size;
        
        % Propagation, calcul de l'erreur, rétropropagation
        [yhat, out] = forward(mynet, x_batch);
        [L, acc] = loss_accuracy(yhat, y_batch);        
        mynet = backward(mynet, out, y_batch, eta);
    end
    
    % pour chaque époque, évaluer l'accuracy sur l'ensemble de test
    [yhat, out] = forward(mynet, Xtest);
    [L, acc] = loss_accuracy(yhat, Ytest);
    accu_test(i) = acc;
end

figure(2);
plot(losses_train);
figure(3);
plot(accu_test);

figure(4);
% Générer une grille de points
[ x1 , x2 ] = meshgrid ( -2:0.1:2) ;
x1 = reshape ( x1 , size ( x1 ,1) ^2 , 1) ;
x2 = reshape ( x2 , size ( x2 ,1) ^2 , 1) ;
Xgrid = [ x1 x2 ];
% Affichage de la classification
[ Ygrid , ~] = forward ( mynet , Xgrid ) ;
grid = Ygrid (: ,1) ;
imagesc ( reshape ( grid , sqrt ( length ( Ygrid ) ) , sqrt ( length ( Ygrid ) ) ) ) ;
caxis ([0.3 , 0.7]) ;
hold on;
plot((Xtrain( Ytrain (: ,1) >.5 ,1) + 2) * 10 ,(Xtrain( Ytrain (: ,1) >.5 ,2) + 2) * 10 , 'bo')
plot((Xtrain( Ytrain (: ,2) >.5 ,1) + 2) * 10 ,(Xtrain( Ytrain (: ,2) >.5 ,2) + 2) * 10 , 'ro')
