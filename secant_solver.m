function [x, x_guesses] = secant_solver(func, x0, x1)

    % define tolerance
    tol = 1e-14;
    max_iter = 100;

    iter = 0;
    
    x_guesses = [];

    while iter < max_iter
        num = func(x1)*(x1 - x0);
        den = (func(x1) - func(x0));

        % calculate new x
        x = x1 - num/den;

        x_guesses(end+1) = x;

        % if denominator is 0, end function
        if abs(den) < tol
            x = NaN;
            return
        end

        if abs(func(x)) < tol
            return
        end

        x0 = x1;
        x1 = x;

        iter = iter+1;
    end
    x = NaN;


end