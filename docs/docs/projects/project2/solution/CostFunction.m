function J = CostFunction(x, params, F)
% x is a vector of optimization parameters
% params is a struct that contains all other parameters
% F is a function that takes x as input and returns solution of tumor model

delta_treat = params.delta_treat;
t_treat = params.t_treat;
if params.opt_times == 0
    delta_treat = x;
else
    delta_treat = x(1:params.N_treat);
    t_treat = x(params.N_treat+1:2*params.N_treat);
end

[g, f, ~] = F([delta_treat, t_treat]);
J = sum(delta_treat.^2) + ...
        + params.a * g(end) ...
        + params.b * Trapezoidal(g, params.dt) ...
        + params.c * Trapezoidal(f, params.dt);

disp(J)
disp(params.c)
end

function trape = Trapezoidal(x, dt)
trape = dt*( 0.5*(x(1) + x(end)) + sum(x(2:length(x)-1)) );
end
