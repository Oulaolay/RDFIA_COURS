%Pour cette fonction elle permet de renvoyer la liste 
% des clusters les plus proches

function [ nc ] = assignementKMeans( listPts , centers)
[N,d]=size(listPts)
[M,d]=size(centers)
%[N,M]=size(squarenormExamples)
nc=zeros(1,N);
normcenters=diag(centers*centers.');
[Nomrcenter,Mormcenter]=size(normcenters)
centersmatrix = repmat(normcenters.',N,1);
%La distance entre les points et les centres
distance=-2*(listPts*centers.')+centersmatrix;
for i=1:N
   [nb,indice]=min(distance(i,:));
   nc(i)=indice;
end
[a,b]=size(nc)
%nc est la liste des clusters les plus proches pour chaque point 
end
