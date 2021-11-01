clear all; clc;

m0 = 1000.; 
v0 = 0.; 
medot = 100.; 
ve = -2000.; 
cd = 0.1; 
tf = 10.; 
tb = 0.4*tf;

% multiple time steps
n = [10];
N = 4;
for i=1:N
    n(i) = n(1) * 2^i;
end

figure('DefaultAxesFontSize',20)
lw = 2;

subplot(2, 1, 1)

t = 0:tf/n(1):tf;
[m, v] = rocket_problem(t, m0, v0, medot, ve, tb, cd);
disp([t(2) - t(1), m(length(t)), v(length(t))]);
plot(t, m, 'DisplayName', sprintf('N = %d', n(1)), 'LineWidth',lw)
for i=2:N
    hold on
    
    n1 = n*i;
    t = 0:tf/n(i):tf; 
    [m, v] = rocket_problem(t, m0, v0, medot, ve, tb, cd);
    
    plot(t, m, 'DisplayName', sprintf('N = %d', n(i)), 'LineWidth',lw)
end 
title('mass')
legend()

subplot(2, 1, 2)

n1 = n;
t = 0:tf/n(1):tf;
[m, v] = rocket_problem(t, m0, v0, medot, ve, tb, cd);
plot(t, v, 'DisplayName', sprintf('N = %d', n(1)), 'LineWidth',lw)
for i=2:N
    hold on
    
    n1 = n*i;
    t = 0:tf/n(i):tf; 
    [m, v] = rocket_problem(t, m0, v0, medot, ve, tb, cd);
    
    plot(t, v, 'DisplayName', sprintf('N = %d', n(i)), 'LineWidth',lw)
end 
title('velocity')
legend()

