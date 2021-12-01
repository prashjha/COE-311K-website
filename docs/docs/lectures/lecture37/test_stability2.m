clear all; clc; clf;

T = 2;

% ode --> dxdt = lambda*x*(x-1), x(0) = x0
lambda = 10;
x0 = 0.9;
f = @(t, x) lambda*x*(x-1);
dfdx = @(t, x) lambda*(2*x-1);

dt = 0.4;
[x_fwd_eul, t_fwd_eul] = forward_euler(dt, f, x0, T);

[x_bck_eul, t_bck_eul] = backward_euler(dt, f, dfdx, x0, T);

dt = 0.0001;
[x_true, t_true] = forward_euler(dt, f, x0, T);

lw = 2;
plot(t_true, x_true, 'r+-', 'DisplayName', 'Exact', 'Linewidth', lw)
hold on
plot(t_fwd_eul, x_fwd_eul, 'go-', 'DisplayName', 'Forward Euler', 'Linewidth', lw)
hold on
plot(t_bck_eul, x_bck_eul, 'bD-', 'DisplayName', 'Backward Euler', 'Linewidth', lw)
legend()