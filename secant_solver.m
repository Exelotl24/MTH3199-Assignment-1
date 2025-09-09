function [x, x_guesses] = secant_solver(func, x0, x1)

    % define tolerance
    tol = 1e-6;
    num = func(x1)*(x1 - x0);
    den = (func(x1) - func(x0));
    x_guesses = [];

    % if denominator is 0, end function
    if abs(den) < tol
        x = NaN;
        return
    end

    % calculate new x
    x = x1 - num/den;

    % if y is still not 0, start recursion
    if abs(func(x)) > tol
        x = secant_solver(func, x1, x);
        x_guesses = [x_guesses, x];
    end



end