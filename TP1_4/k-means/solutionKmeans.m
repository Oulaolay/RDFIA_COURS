function [centers,errorq]=solutionKmeans(listPts,M)
[centers]=randomSeed(listPts,M)
movecenters=1000
while(movecenters~=0)
    %[N,d]=size(listPts)
    %[M,d]=size(centers)
    %squarenorm=diag(listPts*listPts.');
    %[squarenorm_1,squarenorm_2]=size(squarenorm)
    % squarenorm = repmat(squarenorm,1,M);
     %[squarenorm_1,squarenorm_2]=size(squarenorm)
    nc=assignementKMeans(listPts , centers)
    [newcenters,errorq,movecenters] = updateKMeans( listPts , centers  , nc)
    movecenters
    centers=newcenters
    error=errorq
end
end