function [values,w,b]=trainTest(train,test,y)
addpath('libsvm/windows/');
model = svmtrain(y,train, '-c 1000 -t linear');
[w,b] = getPrimalSVMParameters(model);
scalar_product=test*w;
[b_1,b_2]=size(b)
values=scalar_product+(ones(size(scalar_product))*b)

end