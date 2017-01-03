pathBow='../bow_folder/';
nTrain=100
K=1001
%nombre de splits
T=10
%dossier des descripteurs, clusteurs, images
baseDir='../scene/';
baseDirDes='../descriptors3/';
nomDico='../centers_final.mat'
%Image de la figure 6 du TME
nomImage='../scene/MIThighway/image_0002.jpg'
I=imread(nomImage)
sifts_img='../descriptors3/MIThighway/image_0002.mat'
%R�cuperation du vecteur sift et importation dans une variable sift
load(sifts_img)
%R�cup�ration du dictionnaire visuel
load(nomDico)
clusters=centers_final;
%calcul du vecteur contenant les normes des clusters
matNormClusters=diag(clusters*clusters')
% Calcul du BOW
[bow,nc]= computeBow(sifts, clusters, matNormClusters)
patchmin = visuDico( nomDico ,  baseDir , baseDirDes)
categorie_i=10
for t=1:T
    %Fonction qui retourne le nombre d'images par cat�gories
    [imCat,imCatTest] = NbImCatAllTest( pathBow , nTrain)
    %Fonction permettant de g�n�rer les donn�es d'apprentissage et de test
    %et du vecteur ras
    [ train , test , ras ] = loadData2( nTrain , imCat , pathBow, K)
    [size_train1,size_train2]=size(train)
    [size_test1,size_test2]=size(test)
    [size_imcat_1,size_imcat_2]=size(imCat)
    predictclassifieurs=zeros(size_imcat_1,size_test1)
    ntest=imCatTest(categorie_i)
    %G�n�ration des �tiquettes {-1,1}
    [ y, ytest ] = labelsTrainTest( nTrain,ntest,imCat,categorie_i)
    % Cr�ation d'un classifieur binaire pour chaque categorie
    [values,w,b]=trainTest(train,test,y)
    predictclassifieurs(i,:)=values
end
%Calcul la carte de chaleur
[hmap]=compute_prediction_heatmap(I,nc,w);
%Visualisation de la carte de saillance des pr�dictions
visuHeatMap(I,nc,w,hmap,patchmin,nomImage)