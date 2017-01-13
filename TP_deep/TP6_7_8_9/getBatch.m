function [im,labels]=getBatch(imdb,batch)
    batch_size = size(batch,2);
    %Sélection des images et des classes vérités indéxées par batch 
    im = imdb.images.data(:,:,:,batch);
    labels = imdb.images.labels(1,batch);
    for i=1:batch_size
        random_prob=rand;
       if random_prob <= 0.25
           im(:,:,:,i) = fliplr(im(:,:,:,i));
       elseif random_prob <=0.5
           im_tmp = imrotate(im(:,:,:,i),120);
           im(:,:,:,i) = imresize(im_tmp, [64,64]);
       elseif random_prob <=0.75
           im_tmp = imrotate(im(:,:,:,i),240); 
           im(:,:,:,i) = imresize(im_tmp, [64,64]);
       end
    end             
end