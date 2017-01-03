%%%%Fonction Permettant le choix aléatoire des patchs
function [r]=randomPatch(r)
r1=randi(size(r))
r2=randi(size(r))
r=[r(r1);r(r2)]

end