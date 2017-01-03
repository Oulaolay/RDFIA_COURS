function [ confusionMatrix , nGoodCat ] = multiClassPrediction( predictclassifieurs , imCatTest )
[predictclassifieurs_1,predictclassifieurs_2]=size(predictclassifieurs);
[imCatTest_1,imCatTest_2]=size(imCatTest );
 confusionMatrix=zeros(imCatTest_1,imCatTest_1);
 preced_img=1;
for i=1:imCatTest_1
    nbr_image=imCatTest(i)
    for j=preced_img:(preced_img+nbr_image-1)
        [val,index]=max(predictclassifieurs(:,j));
        confusionMatrix(index,i)=confusionMatrix(index,i)+1;
    end
    preced_img=preced_img+nbr_image;
end
imCatTest=imCatTest';
for i=1:imCatTest_1
    confusionMatrix(i,:)=rdivide(confusionMatrix(i,:),imCatTest)*100;
end
 nGoodCat=diag(confusionMatrix);
 confusionMatrix=confusionMatrix';
 nGoodCat=nGoodCat';
end