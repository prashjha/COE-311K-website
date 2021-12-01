function x = newtonraphson(f, dfdx, x0, ea_tol, max_it)
    numIterations = 0;
    x_old = x0;
    x = x0;
    ea = 100;
    
    while (ea > ea_tol)
        numIterations = 1 + numIterations;
        
        x_old = x;
        
        x = x_old - f(x_old) / dfdx(x_old);
        
        if abs(x) > 1e-10
            ea = abs((x - x_old) / x) * 100;
        else
            ea = 0;
        end
        
        if numIterations >= max_it
            break;
        end
        
    end
end