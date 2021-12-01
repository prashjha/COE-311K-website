clear all; clc; clf;

T = 10;

% ode --> dxdt = -lambda*x, x(0) = x0
% x(t) = x0*exp(-lambda*t)
lambda = 10;
x0 = 1;
f = @(t, x) -lambda*x;
dfdx = @(t, x) -lambda;

x_exact = @(x) x0*exp(-lambda*x);

dt = 0.2;
[x_fwd_eul, t_fwd_eul] = forward_euler(dt, f, x0, T);

[x_bck_eul, t_bck_eul] = backward_euler(dt, f, dfdx, x0, T);

lw = 2;
plot(t_fwd_eul, x_exact(t_fwd_eul), 'r+-', 'DisplayName', 'Exact', 'Linewidth', lw)
hold on
plot(t_fwd_eul, x_fwd_eul, 'go-', 'DisplayName', 'Forward Euler', 'Linewidth', lw)
hold on
plot(t_bck_eul, x_bck_eul, 'bD-', 'DisplayName', 'Backward Euler', 'Linewidth', lw)
legend()