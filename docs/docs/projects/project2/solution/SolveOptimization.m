clear all; clc; clf;

params.T = 50;
params.lam_p = 0.1;
params.lam_a = 0.005;
params.lam_k = 4;
params.lam_d = 0.05;
params.sig = 2;

N_steps = 2^3*100;
dt = params.T / N_steps;
params.dt = dt;

N_treat = 4;
params.N_treat = N_treat;
t_treat = [10, 20, 30, 40];
params.t_treat = t_treat;
delta_treat = [0.001, 0.001, 0.001, 0.001];
params.delta_treat = delta_treat;

a = 0.0005;
b = 0.00005;
c = 0;
params.a = a;
params.b = b;
params.c = c;

params.g0 = 0.01;
params.f0 = 0.001;

%% test model
[g, f, t] = TumModel([delta_treat, t_treat], params);

%% test convergence of discretization
test_convg = 0;
if test_convg == 1
    figure(2)
    subplot(2,2,1)
    N_steps_vec = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    norm_vec = zeros(length(N_steps_vec), 4);
    for i=1:length(N_steps_vec)
        Ni = 2^(N_steps_vec(i))*100;
        params.dt = params.T / Ni;
        [gg, ff, tt] = TumModel([delta_treat, t_treat], params);
        norm_vec(i,1) = params.dt*norm(gg,1);
        norm_vec(i,2) = params.dt*norm(ff,1);
        norm_vec(i,3) = gg(end);
        if i > 1
            norm_vec(i,4) = 100 * (norm_vec(i,3) - norm_vec(i-1,3)) /norm_vec(i,3);
        end
        
        plot(tt, gg, 'DisplayName', string(Ni))
        if i < length(N_steps_vec)
            hold on
        end
    end
    legend()
    disp('norm_vec')
    norm_vec
    subplot(2,2,2)
    plot(N_steps_vec, norm_vec(:,1), '+', 'LineWidth', 2)
    title('Tumor L2 norm')
    subplot(2,2,3)
    plot(N_steps_vec, norm_vec(:,2), 'o', 'LineWidth', 2)
    title('Drug L2 norm')
    subplot(2,2,4)
    plot(N_steps_vec, norm_vec(:,4), 'o', 'LineWidth', 2)
    title('Error in g(T)')
    
    params.dt = dt;
end

%% optimization
params.opt_times = 0;
Fx = @(x) TumModel(x, params);
Jx = @(x) CostFunction(x, params, Fx);
x0 = delta_treat;
pmin = zeros(1, N_treat);
pmax = zeros(1, N_treat) + 0.01;

tolx=1.e-9;
tolfun=1.e-9;
maxiter=400;

tic;
[xopt,fval,exitflag,output,lambda,grad,hessian] ...
    = fmincon(Jx, x0,[],[],[],[],pmin,pmax,[], ...
        optimset('TolX',tolx,'TolFun',tolfun,'MaxIter', ...
        maxiter,'Display','iter-detailed'));
toc;


disp('initial guess')
disp(x0)
disp('optimal drug dosing')
disp(xopt)
params.delta_treat = xopt;
[gopt, fopt, t] = Fx([xopt, t_treat]);

%% optimization (with time points)
params.opt_times = 1;
if params.opt_times == 1
    params.c = 0.001;
    Fx = @(x) TumModel(x, params);
    Jx = @(x) CostFunction(x, params, Fx);

    x0 = [delta_treat, t_treat];
    x0(N_treat+1:2*N_treat) = [9.7955, 19.5171, 30.6384, 40.6257];
    pmin = zeros(1, 2*N_treat);
    pmax = zeros(1, 2*N_treat);
    
    for i=1:N_treat
        pmax(i) = 0.01;

        pmin(N_treat + i) = (i-1)*10 + 5;
        pmax(N_treat + i) = (i-1)*10 + 15;
        %x0(N_treat + i) = x0(N_treat + i) + 2*randn(1,1);
    end
    
    tolx=1.e-9;
    tolfun=1.e-9;
    maxiter=400;

    tic;
    [xopt2,fval,exitflag,output,lambda,grad,hessian] ...
        = fmincon(Jx, x0,[],[],[],[],pmin,pmax,[], ...
            optimset('TolX',tolx,'TolFun',tolfun,'MaxIter', ...
            maxiter,'Display','iter-detailed'));
    toc;

    params.delta_treat = xopt2(1:N_treat);
    params.t_treat = xopt2(N_treat+1:2*N_treat);
    disp('initial guess (time points)')
    disp(x0)
    disp('optimal drug dosing (time points)')
    disp(params.delta_treat)
    disp(params.t_treat)
    [gopt2, fopt2, t] = Fx([params.delta_treat, params.t_treat]);
end

%% plotting
lw = 1;
figure(1)
subplot(2,1,1)
plot(t, g, 'r+', 'LineWidth', lw, 'DisplayName', 'initial guess')
hold on
plot(t, gopt, 'bo', 'LineWidth', lw, 'DisplayName', 'optimal')
if params.opt_times == 1
    hold on
    plot(t, gopt2, 'gs', 'LineWidth', lw, 'DisplayName', 'optimal (time points)')
end
legend()
title('Tumor')

subplot(2,1,2)
plot(t, f, 'r+', 'LineWidth', lw, 'DisplayName', 'initial guess')
hold on
plot(t, fopt, 'bo', 'LineWidth', lw, 'DisplayName', 'optimal')
if params.opt_times == 1
    hold on
    plot(t, fopt2, 'gs', 'LineWidth', lw, 'DisplayName', 'optimal (time points)')
end
legend()
title('Drug')
