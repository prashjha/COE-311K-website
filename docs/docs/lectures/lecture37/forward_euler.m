function [x, t] = forward_euler(dt, f, x0, T)
% dx/dt = f(t, x(t))

N = floor(T/dt);
t = linspace(0, T, N); %0:dt:(T-dt);
x = zeros(1, N);
x(1) = x0;

for i=2:N
    x(i) = dt * f(t(i-1), x(i-1)) + x(i-1);
end
