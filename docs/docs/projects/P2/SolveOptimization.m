clear all; clc; clf;

%% Set parameters 

% e.g.
T = 50;
g0 = 0.01;
f0 = 0.001;

% add other parameters

% create Matlab struct to collect all parameters in one object
params.T = T;
params.g0 = g0;
params.f0 = f0;

% keep adding other parameters to 'params'

% you can access values from 'params' using params.T, params.g0, ...

%% Optimization setup

% set initial guess for optimization parameters
x0 = ??;

% define function that computes cost function J
% using struct 'params' you don't need to pass lengthy list of parameters
Fx = @(x) TumModel(x, params);  % tumor model
Jx = @(x) CostFunction(x, params, Fx); % cost function

% set constraints (lower and upper bounds)
xmin = ??;  % vector of lower bound for all elements of x vector
xmax = ??;  % vector of upper bound for all elements of x vector

% fmincon parameters (you may leave this unchanged)
tolx = 1.e-9;
tolfun = 1.e-9;
maxiter = 400;

%% Run optimization
tic;
[xopt, Jval, ~, ~, ~, ~, ~] = fmincon(Jx, x0, [], [], [], [], ...
                                xmin, xmax,[], ...
                                optimset('TolX',tolx, ...
                                'TolFun', tolfun, ...
                                'MaxIter', maxiter, ...
                                'Display','iter-detailed'));
toc;

% display results
disp('initial guess')
disp(x0)
disp('optimal parameters')
disp(xopt)

%% Plotting
% compute solution using optimal parameters
[g0, f0, t] = F(x0);

% compute solution using optimal parameters
[gopt, fopt, t] = F(xopt);

% plot and compare results