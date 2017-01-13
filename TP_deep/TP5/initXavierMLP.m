function [ net ] = initXavierMLP(nx,nh,ny)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

moy = 0;
var = 0.3;
net = struct;

net.b_h = zeros(nh,1);
net.W_h = (moy + var*(randn(nh,nx)))/sqrt(nx);

net.b_y = zeros(ny,1);
net.W_y = (moy + var*(randn(ny,nh)))/sqrt(nh);

end

