function [ nc ] = assignementKMeans2( listPts , centers , squarenormExamples)
[N,d]=size(listPts)
[M,d]=size(centers)
[N,M]=size(squarenormExamples)
nc=zeros(1,M);
normcenters=diag(centers*centers.');
[Nomrcenter,Mormcenter]=size(normcenters)
centersmatrix = repmat(normcenters.',N,1);
distance=-2*(listPts*centers.')+squarenormExamples+centersmatrix;
for i=1:M
   [nb,indice]=min(distance(:,i));
   nc(i)=indice;
end
[a,b]=size(nc)
end