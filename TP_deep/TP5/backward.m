function [ net ] = backward( net, out, Y, eta)

[n, ~] = size(Y);
delta_y = out.Yhat-Y;

net.b_y = net.b_y - eta/n*(sum(delta_y,1)');
net.W_y = net.W_y - eta/n*(delta_y'*out.h);

delta_h = (delta_y*net.W_y).*(1-(tanh(out.h_tilde).^2));
net.b_h = net.b_h - eta/n*(sum(delta_h,1)');
net.W_h = net.W_h - eta/n*(delta_h'*out.X);

end

