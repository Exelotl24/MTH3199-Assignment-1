function [x, x_guesses] = secant_solver(fun, x0, x1)

    syms x

    % define tolerance
    tol = 1e-10;
    max_iter = 200;

    iter = 0;
    
    x_guesses = [];
    
    if isa(fun, 'sym')
        fun_eval = matlabFunction(fun, 'Vars', x);
    else
        fun_eval = fun;
    end

    while iter < max_iter
        num = fun_eval(x1)*(x1 - x0);
        den = (fun_eval(x1) - fun_eval(x0));

        % calculate new x
        x = x1 - num/den;

        x_guesses(end+1) = x;

        % if denominator is 0, end function
        if abs(den) < tol
            x = NaN;
            return
        end

        if abs(fun_eval(x)) < tol
            return
        end

        x0 = x1;
        x1 = x;

        iter = iter+1;
    end
    x = NaN;


end