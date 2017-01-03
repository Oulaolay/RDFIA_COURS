function [ hmap ] = compute_prediction_heatmap( I , nc , w )
s=16
delta=8
[r] = denseSampling( I, s, delta );
[I_size1,I_size2]=size(I);
[r_size_1,r_size2]=size(r)
hmap=zeros(I_size1,I_size2);
for i = 1:r_size2
    tmp=nc(i);
    final=w(tmp)*ones(s,s);
    index_ligne=r(1,i);
    index_colonne=r(2,i);
    hmap(index_ligne:index_ligne+s-1,index_colonne:index_colonne+s-1)=final/r_size2+hmap(index_ligne:index_ligne+s-1,index_colonne:index_colonne+s-1);
end
end