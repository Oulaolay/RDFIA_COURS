function model = train_classifier(X_train, y_train, C)

% get the classes index and sort (ideally 1 to N_classes)
ys = sort(unique(y_train))';

% init structure
model = struct;
model.ys = ys;
model.svms = {};

% for each class index in trainset
for yi = ys
    % create a the binary target vector with -1 / 1 for class yi
    y_svm = y_train * 0 - 1;
    y_svm(y_train == yi) = 1;
    
    % train the binary linear SVM, put in output struct
    model.svms{yi} = svmtrain(y_svm, X_train, ['-c ' num2str(C) ' -t linear']);
end
