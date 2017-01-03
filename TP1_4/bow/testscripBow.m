baseDir='../scene/';
baseDirDes='../descriptors3/';
nomDico='../centers_final.mat'
load(nomDico)
clusters=centers_final
%Ouverture d'une image aléatoire de la base
[ I , nomim , sifts] = randomImageDes( baseDir , baseDirDes)
%calcul du vecteur contenant les normes des clusters
matNormClusters=diag(clusters*clusters')
% Calcul du Bow et du nc(clusters le plus proche du dictionnaire)
[bow,nc]= computeBow(sifts, clusters, matNormClusters)
%création des matchs d'après la visualisation du dictionaire
patchmin = visuDico( nomDico ,  baseDir , baseDirDes)
%Visualisation du Bow
visuBoW( I , patchmin , bow ,  nc , nomim)