%Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
function [x, x_guesses] = newton_solver(functions, x)
    
    % define tolerance and functions
    tol = 1e-6;
    func = functions{1};
    dfdx = functions{2};
    x_guesses = [];

    % newton's update loop is x_(n+1) = x_n - f(x_n)/f'(x_n)
    while abs(func(x)) > tol && abs(dfdx(x))>tol
        x = x - (func(x)/dfdx(x));
        x_guesses = [x_guesses, x];
    end
    
end