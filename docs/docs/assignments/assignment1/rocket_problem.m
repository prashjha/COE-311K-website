function [m, v] = rocket_problem(t, m0, v0, medot, ve, tb, cd)
% rocket_problem: solves the mass and velocity equation for rocket
% [m, v] = rocket_problem(t, m0, v0, medot, ve, tb, cd)
% input:
% t = discrete set of times (s) (vector)
% m0 = initial mass (kg) (scalar)
% v0 = initial velocity of rocket (m/s) (scalar)
% medot = mass ejection rate (kg/s) (scalar)
% ve = relative (negative) velocity of mass ejecting (m/s) (scalar)
% tb = maximum time upto mass will eject and then stop (s) (scalar)
% cd = drag coefficient (kg/m) (scalar)
% output:
% m = mass of rocket at different times (kg) (vector)
% v = velocity of rocket at different times (m/s) (vector)

g = 9.81;
m = [m0]; % we will dynamically increase it's size
v = [v0]; % we will dynamically increase it's size

% get time step size and number of steps
dt = t(2) - t(1);
n = length(t);

% solve
for i=2:n
    % check if mass is strictly above zero as v is ill-defined
    % when m <= 0
    medot_now = 0.;
    if t(i) <= tb
        medot_now = medot;
    else
        medot_now = 0;
    end
    if m(i-1) > 0
        m(i) = m(i-1) + dt * (-medot_now);
        b = (medot_now * (v(i-1) - ve) / m(i-1)) - g - (cd * v(i-1)^2 / m(i-1));
        v(i) = v(i-1) + dt * b;
    else
        m(i) = m(i-1);
        v(i) = v(i-1);
    end
end