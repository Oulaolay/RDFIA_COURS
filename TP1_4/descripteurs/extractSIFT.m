function [Ig,Ior,sifts] = extractsift(I,s,delta,r)
%Calcul du gradient
[Ix,Iy] = compute_gradient(I);
%Calcul du module du gradient
Ig=sqrt(Ix.^2+Iy.^2);
%Calcul des oritentation du gradient en chaque pixel
[Ior]=orientation(Ix,Iy,Ig);
%Calcul du masque gaussien
[Mg]=gaussSIFT(s);
%récupération de la valeur en haut à gauche du patch
index_ligne=r(1,1);
index_colonne=r(2,1);
%Calcul des Ig et Ior selon le patch
Ig_bis=Ig(index_ligne:index_ligne+s-1,index_colonne:index_colonne+s-1);
Ior_bis=Ior(index_ligne:index_ligne+s-1,index_colonne:index_colonne+s-1);
%Calcul du descripteur sift
[sifts] = computeSIFT(s,Ig_bis,Ior_bis,Mg);

end