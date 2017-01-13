function [ Yhat, out ] = forward( net, X)
[k, ~] = size(X);
out = struct;

out.X = X;
out.h_tilde = X * net.W_h' + repmat(net.b_h', k, 1);
out.h = tanh(out.h_tilde);

out.y_tilde = out.h * net.W_y' + repmat(net.b_y', k, 1);
Yhat = exp(out.y_tilde)./(sum(exp(out.y_tilde),2));
out.Yhat = Yhat;

end

