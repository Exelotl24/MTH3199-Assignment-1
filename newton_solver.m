%Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
function [x_val, x_guesses] = newton_solver(functions, x_val)
    syms x

    % define tolerance and functions
    max_iters = 1000;
    tol = 1e-6;
    fun = functions(1);
    dfdx = functions(2);

    if isa(fun, 'sym')
        fun_eval = matlabFunction(fun, 'Vars', x);
        dfdx_eval = matlabFunction(dfdx, 'Vars', x);
    else
        fun_eval = fun;
        dfdx_eval = dfdx;
    end
    
    x_guesses = [];

    iter = 0;

    % newton's update loop is x_(n+1) = x_n - f(x_n)/f'(x_n)
    while abs(fun_eval(x_val)) > tol && abs(dfdx_eval(x_val))>tol && iter<max_iters
        x_val = x_val - (fun_eval(x_val)/dfdx_eval(x_val));
        x_guesses(end+1) = x_val;
        iter = iter+1;
    end

    
end