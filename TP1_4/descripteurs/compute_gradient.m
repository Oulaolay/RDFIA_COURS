%Fonction permettant de calculer le gradient
function [Ix,Iy] = compute_gradient(I)
Ix = convolution_separable(I,[-1,0,1],[1;2;1]/4);
  Iy = convolution_separable(I,[1,2,1],[-1;0;1]/4);
end