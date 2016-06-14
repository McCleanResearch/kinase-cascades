function y = approx_func(t, x, eps, f0, beta)

t_n = int16((t - mod(t, eps))/eps + 1);
x_n = x(find(t==(t - mod(t, eps))));
approx_x = x_n(t_n);
y = zeros(length(t), 1);
y(1) = f0;
approx_func = @(t,x,y0)(beta(1)*x./(beta(1)*x + beta(2)) - (beta(1)*x./(beta(1)*x + beta(2)) - y0).*exp(-(beta(1)*x + beta(2)).*t));
cur_y0 = f0;
for i=1:(t(end)-t(1))/eps
    indices = find((t>(i-1)*eps) & (t <= i*eps));
    y(indices) = approx_func(t(indices), approx_x(indices), cur_y0);
    cur_y0 = y(find(abs(t - i*eps) < 0.0001));
end

% y = x_n;

% num = (length(t))/eps;
% 
% y = zeros(length(t), 1);
% y(1:eps) = beta(1)*x(1)/(beta(1)*x(1) + beta(2)) - (beta(1)*x(1)/(beta(1)*x(1) + beta(2)) - f0)*exp(-(beta(1)*x(1) + beta(2))*t(1:eps));
% 
% for i=1:num-1
%     y(i*eps+1:(i + 1)*eps) = beta(1)*x(i*eps)/(beta(1)*x(i*eps) + beta(2)) - (beta(1)*x(1)/(beta(1)*x(i*eps) + beta(2)) - y(i*eps))*exp(-(beta(1)*x(i*eps) + beta(2))*t(i*eps+1:(i + 1)*eps)); 
% end