pathBow='../bow_folder/';
%nombre d'exemples utilisés
nTrain=100
K=1001
% nombre de split
T=20
%Initalisation des matrices permettant d'obtenir  le taux de reconnaissance
%sur les 15 catégories et la matrices de confusion
all_GoodCat=zeros(10,15)
final_GoodCat=zeros(1,15)
final_GoodCat_var=zeros(1,15)
all_confusionMatrix=zeros(15,15)
tstarttot= tic;
%Lancement des 20 splits
for t=1:T
    %Fonction qui retourne le nombre d'images par catégories
    [imCat,imCatTest] = NbImCatAllTest( pathBow , nTrain)
    %Fonction permettant de générer les données d'apprentissage et de test
    [ train , test ] = loadData( nTrain , imCat , pathBow, K)
    [size_train1,size_train2]=size(train)
    [size_test1,size_test2]=size(test)
    [size_imcat_1,size_imcat_2]=size(imCat)
    predictclassifieurs=zeros(size_imcat_1,size_test1)
    for i=1:size_imcat_1
        %taille du fichier de test pour chaque catégorie i 
        ntest=imCatTest(i)
        %Génération des étiquettes {-1,1}
        [ y, ytest ] = labelsTrainTest( nTrain,ntest,imCat,i)
        % Création d'un classifieur binaire pour chaque categorie
        [values,w,b]=trainTest(train,test,y)
        predictclassifieurs(i,:)=values
    end
    
%Confusion matrix & taux de reconnaissance
[confusionMatrix,nGoodCat] = multiClassPrediction(predictclassifieurs,imCatTest)
[sizegood_1,size_good2]=size(nGoodCat)
[sizeconfus_1,size_confus_2]=size(confusionMatrix)
%Ajout de la matrice à chaque split itération
all_confusionMatrix=all_confusionMatrix+confusionMatrix
%ajout du vecteur à chaque split itération
all_GoodCat(t,:)=nGoodCat
end
cate = categories2()
categorie=1:15
%Moyenne et variance de la fonction GoodCat
for i=1:15
    final_GoodCat(i)=mean(all_GoodCat(:,i))
    final_GoodCat_var(i)=var(all_GoodCat(:,i))
end
disp('Moyenne de nGoodCat suivant 20 splits')
final_GoodCat
disp('Variance de nGoodCat suivant 20 splits')
final_GoodCat_var
%Figure de la matrice de confusion moyennée et du graphique de
%reconnaissance moyenné
figure
subplot(1,2,1)
plot(categorie, final_GoodCat);
set(gca,'xtickLabel',cate, 'xtick',categorie,'Fontsize',8)
subplot(1,2,2)
final_confusionMatrix=all_confusionMatrix/(T*norm(confusionMatrix))
imagesc(final_confusionMatrix)
colormap(flipud(hot))
colorbar
title('Matrice de Confusion')
tcal = toc(tstarttot);