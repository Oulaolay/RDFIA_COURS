function [ net ] = initMLP(nx,nh,ny)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

moy = 0;
var = 0.3;
net = struct;

net.b_h = moy + var*(randn(nh,1));
net.W_h = moy + var*(randn(nh,nx));

net.b_y = moy + var*(randn(ny,1));
net.W_y = moy + var*(randn(ny,nh));

end

