baseDir='../scene/';
baseDirDes='../descriptors3/';
nomDico='../centers_final.mat'

cate = categories();
pathdes = '../descriptors3/';

pathbow = '../bow_folder/';

s= 16;
delta = 8;

catinit = 1;
catend =15;
load(nomDico)
clusters=centers_final

tstarttot= tic;
for index=catinit:catend
    cat = cate{index};
    pathcat = strcat(pathbow,cat,'/');
    if(exist(pathcat)==0)
        mkdir(pathcat);
    end
    
    
    
    direc = strcat(pathdes,cat,'/');
    listima=dir([direc '*.mat'] );
    n=length(listima)
    for num=1:n
        
        sift_img = strcat(direc,listima(num).name);
        load(sift_img);
        
        %calcul du vecteur contenant les normes des clusters
        matNormClusters=diag(clusters*clusters')
        % Calcul du Bow
        disp(sifts)
        disp(class(clusters))
        [bow,nc]= computeBow(sifts, clusters, matNormClusters)
        desnames=strcat(pathcat,listima(num).name(1:length(listima(num).name)-4),'.mat');
        save(desnames,'bow')
        disp(desnames)
        %patchmin = visuDico( nomDico ,  baseDir , baseDirDes)
        %visuBoW( I , patchmin , bow ,  nc , nomim)
        
        
        if(mod(num,100)==0)
            strcat('nb patchs=',num2str(size(sifts,2)))
            tcal = toc(tstarttot);
            strcat('temps de calcul =',num2str(tcal))
        end
    end
end