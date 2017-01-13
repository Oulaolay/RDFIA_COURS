function [y_hat, Y_hat_scores] = predict_classifier(model, X)

% init scores to NaN (NaN will remain if some classes index weren't in train set)
Y_hat_scores = nan(size(X,1), max(model.ys));

% for each class index in train set
for yi = model.ys
    
    % load model, extract w, b
    model_i = model.svms{yi};
    w = model_i.SVs' * model_i.sv_coef;
    b = -model_i.rho;
    if model_i.Label(1) == -1
        w = -w;
        b = -b;
    end

    % compute scores and put in right index column
    Y_hat_scores(:, yi) = X * w + b;
end

% get argmax of scores for class prediction
[~, y_hat] = max(Y_hat_scores, [], 2);
