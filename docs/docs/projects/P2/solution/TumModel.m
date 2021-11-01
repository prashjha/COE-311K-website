function [g, f, t] = TumModel(x, params) 
% x is a vector of optimization parameters
% params is a struct that contains all other parameters

delta_treat = x(1:params.N_treat);
t_treat = x(params.N_treat+1:2*params.N_treat);

t = 0:params.dt:params.T;
N = length(t);

g = zeros(N,1);
f = zeros(N,1);

g(1) = params.g0;
f(1) = params.f0;

for i=2:N
    gii = g(i-1); fii = f(i-1);
    dgdt = params.lam_p * gii * (1. - gii) - params.lam_a * gii ...
           - params.lam_k * gii * fii;
    dfdt = -params.lam_d * fii + dinp(t(i-1), delta_treat, t_treat, params.sig);
    
    g(i) = gii + params.dt * dgdt;
    f(i) = fii + params.dt * dfdt;
end

end

function p = dinp(t, delta_treat, t_treat, sig)
    p = 0;
    for j=1:length(delta_treat)
        p = p + delta_treat(j) * exp(-0.5*(t_treat(j) - t)^2/sig^2) / (sig * sqrt(2*pi));
    end
end

