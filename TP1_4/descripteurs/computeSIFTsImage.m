%%%Fonction permettant de calculer l'ensemble des descripteurs SIFTS de
%%%l'image
function [sifts,r] = computeSIFTsImage(I,s,delta)
[ r ] = denseSampling( I, s, delta )
[r_ligne,r_colonne]=size(r)
sifts=zeros(128,r_colonne)

%Calcul du gradient
[Ix,Iy] = compute_gradient(I)
%Calcul du module du gradient
Ig=sqrt(Ix.^2+Iy.^2);
%Calcul des oritentation du gradient en chaque pixel
[Ior]=orientation(Ix,Iy,Ig);
%Calcul du masque gaussien
[Mg]=gaussSIFT(s);
for i=1:r_colonne
    %Calcul du descripteur sift
    index_ligne=r(1,i);
    index_colonne=r(2,i);
    Ig_bis=Ig(index_ligne:index_ligne+s-1,index_colonne:index_colonne+s-1)
    Ior_bis=Ior(index_ligne:index_ligne+s-1,index_colonne:index_colonne+s-1)
    disp('---------------------------------------')
    [Ior_size1,Ior_size_2]=size(Ior_bis)
    disp('--------------------------------------')
    %%%%Calcul des SIFTS avec la fonction computeSIFT_modifier
    sifts(:,i) = computeSIFT_modif(s,Ig_bis,Ior_bis,Mg);
    
end
end