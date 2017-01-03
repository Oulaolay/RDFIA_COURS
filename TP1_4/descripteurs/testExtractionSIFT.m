clear all;
close all;


s= 16;
delta = 8;
tstarttot= tic;

%%%%%%%%%%%% Creation des descripteurs l'image "jouet" %%%%%%%%%%%%%%%
    %I=marche()
    %r=[125;100] %%%choix du patchs
    %r=[97;121] %Choix du patch 
    %r=[121;121] %Choix du patchs
    
%%%%%%%%%%%%% Création des descripteurs de l'image "tools" %%%%%%%%%
    %I=imread('../scene_test/tools/tools.gif') %%Lecture de l'image jouet
    %r=[80;200]
    %r=[173;250]

%%%% Création des descripteurs pour image et un patch tirés aléatoirement
    pathImg='../scene/';
    [I,nomim] = randomImage(pathImg);
    r = denseSampling(I, s, delta);
    r=randomPatch(r);
%%%%%%%%%%% des Extraction sifts %%%%%%%%
[Ig,Ior,sifts]=extractSIFT(I,s,delta,r);

%desname='../descriptors3_test/tools/marche.mat'
%desname='../descriptors3_test/tools/tools.mat'
desname=nomim

visuSIFT(I,Ig,Ior,r,desname,s,sifts);
sifts=uint8(sifts*255);
save(desname,'sifts');

tcaltot = toc(tstarttot);

strcat('Temps pour image tools :',num2str(tcaltot))


















