
clear;

%% Chargement des données
load('mnist.mat');

% On transforme les données en données centrées réduites
moys = mean([Xtrain;Xtest]);
variance = std([Xtrain;Xtest]);

% Centrer et réduire les pixels dont la variance n'est pas nulle !
% ... utiliser boucle for ...
for i= 1:length(variance)
    if variance(i) ~= 0
        Xtrain(i,:) = (Xtrain(i,:) - moys(i))./variance(i); 
        Xtest(i,:) = (Xtest(i,:) - moys(i))./variance(i);
    end
end

%% Propagation, évaluation de l'erreur et rétro-propagation
% hyperparamètres
nb_epoch = 200;
nh = 100;
eta = 0.1;
batch_size = 1000; % Must be diviseur de 60000

% initialisation du réseau de neurones
mynet = initXavierMLP(784,nh,10);

[npoints, ~] = size(Xtrain);
loss_index_train = 1;

for i=1:nb_epoch
    i
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
    