%Fonction de mise à jour des centres qui renvoie l'erreur de quantification
% les nouveaux centres et norme entre les nouveaux et anciens centres.
function [ newcenters , errorq , movecenters ] = updateKMeans( listPts , centers  , nc)
   [M,d]=size(centers);
   movecenters=0;
   [N,d]=size(listPts);
   errorq_vec=zeros(N,d);
   errorq=0;
   newcenters=zeros(M,d);
   for i=1:M
       compt=0;
     for k=1:N
             if nc(k)==i
                 newcenters(i,:)=listPts(k,:)+newcenters(i,:);                 
                 compt=compt+1;
              end
             
     end
     
       if compt>0
            newcenters(i,:)=(1/compt)*newcenters(i,:);
            
             
       end
       
   end
   movecenters=norm(newcenters-centers,'fro')^2;
 
   for i=1:N
           errorq=norm(newcenters(nc(i),:)-listPts(i,:))^2+errorq;
          
   end
    

end