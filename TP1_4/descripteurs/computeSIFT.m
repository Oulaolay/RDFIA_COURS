function [ sift ] = computeSIFT( s , Ig, Ior, Mg )
  sift = zeros(128,1);
  compt=0;
  for i=1:4 
      for j=1:4
          hist=zeros(8,1);
          for k=(i-1)*4+1:(i*4)
              for l=(j-1)*4+1:(j*4)
                  if Ior(k,l)>0
                      hist(Ior(k,l))=hist(Ior(k,l))+Mg(k,l)*Ig(k,l);
                  end
              end
          end
      sift(compt*8+1:(compt+1)*8)=hist;
      compt=compt+1;
      end

  end
  if norm(sift)>0
      sift=sift/norm(sift)
      sift=min(sift,0.2)
      sift=sift/norm(sift)
  end