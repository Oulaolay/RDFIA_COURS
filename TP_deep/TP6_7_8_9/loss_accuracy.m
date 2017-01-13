function [ L, acc ] = loss_accuracy(Yhat, Y)
% vecteur de coût L de taille k et le scalaire acc correspondant à la prédiction

L = -sum(Y .* log(Yhat),2);
[k, ~] = size(Y);

[~, indicesYhat] = max(Yhat,[],2);
[~, indicesY]=max(Y,[],2);
acc = sum(indicesYhat==indicesY)/k;
end

