function [x, t] = backward_euler(dt, f, dfdx, x0, T)
% dx/dt = f(t, x(t))

N = floor(T/dt);
t = linspace(0, T, N); 
x = zeros(1, N);
x(1) = x0;
ea_tol = .1;
maxit = 100;

for i = 2:N
    % dx/dt = (x(i) - x(i-1)) / dt = f(t(i),x(i))
    % x(i) = f(t(i),x(i))*dt + x(i-1)
    % h(z) = z - x(i-1) - dt*f(t(i),z)
    % h(x(i)) = 0
    % x(i) = f(t(i),x(i))*dt + x(i-1)
    h = @(z) z - x(i-1) - dt*f(t(i),z);
    dhdz = @(z) 1 - dt*dfdx(t(i),z);
    x(i) = newtonraphson(h, dhdz, x(i-1), ea_tol, maxit);
    %x(i) = fixedpointiteration(h, x(i-1), ea_tol, maxit);
end