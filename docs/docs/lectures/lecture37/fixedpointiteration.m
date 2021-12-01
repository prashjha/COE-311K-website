function x = fixedpointiteration(f, x0, ea_tol, maxit)

g = @(x) x - f(x);
iter = 0; ea = 100; xold = x0; x = x0;

while (ea > ea_tol && iter < maxit)
    iter = iter + 1;
    xold = x;
    % find x such that x = g(x)
    % x0, x1 = g(x0), x2 = g(x1), x3 = g(x2), ...
    x = g(xold);
    
    if abs(x) > 1E-10
        ea = abs((x-xold)/x)*100;
    else
        ea = 0;
    end
    
end