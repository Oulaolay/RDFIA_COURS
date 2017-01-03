
dir='../descriptors3/';
[listPts,norm]=randomSampling(dir);
%Nombre de mots visuels du dictionnaire
M=1000;
%Nombre de kmeans pour avoir la meilleur initalisation des centres
test_kmeans=10;
%Erreur de quantification initalisée
error_tmp=100000000000000000000;
%Tests des 10 k_means
tstarttot= tic;
for i=1:test_kmeans
[centers,error]=solutionKmeans(listPts,M);

if(error<error_tmp)
    centers_final=centers;
    error_tmp=error;
    
end
end
%veteurs null que l'on rajoute
vect_null=zeros(1,128)
centers_final=[centers_final;vect_null]
desname = '../centers_final.mat';
%Sauvegarde de la variable centers_final dans centers_final.mat
save(desname,'centers_final');
centers_final
tcaltot = toc(tstarttot);