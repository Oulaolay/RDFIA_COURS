function [bow,nc]= computeBow(sifts, clusters, matNormClusters)
% INPUT: 
% sifts : a 128xN matrix containing local descriptors for an image
% clusters: a Kx128 matrux containing the set of visual words
% matNormClusters a Kx1 vector containing clusters norms
[d,N]=size(sifts);
[K,d]=size(clusters);
matnornmatrix = repmat(matNormClusters,1,N); %NxK
bow=zeros(N,1);
transi_bow=zeros(N,K); %KxN
sifts=sifts.'; %Nxd
sifts=double(sifts); %Nxd
nc=assignementKMeans2(clusters, sifts, matnornmatrix);
for i=1:N
    indice=nc(i); %nc=un vecteur K avec des indice allant de 1‡N
    transi_bow(i,indice)=1;
end
[tansi_box,transi]=size(transi_bow)
bow=sum(transi_bow);
bow=bow/N;
bow=bow';
end





