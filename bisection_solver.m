% bisection_solver finds the roots of a given function starting from two
% guesses by splitting the data in half each time using recursion

function [x_val, x_guesses] = bisection_solver(fun,x_left,x_right)

    % initialize variables
    syms x
    tol = 1e-14;
    max_iter = 100;
    iter = 0;
    x_guesses = [];


    % Make sure function can be called
    if isa(fun, 'sym')
        fun_eval = matlabFunction(fun, 'Vars', x);
    else
        fun_eval = fun;
    end
    

    while iter < max_iter

        % calculate x_mid
        x_mid = (x_left+x_right)/2;
    
        % calculate function for each x value
        y_left = fun_eval(x_left);
        y_mid = fun_eval(x_mid);
        y_right = fun_eval(x_right);
    
        % x_guesses(end+1) = x_mid;
    
        
        if abs(y_mid)<tol
            % test if any values are roots
            x_val = x_mid;
            return;
        elseif (y_left*y_mid)<0
            % if left and mid are different signs, look for root
            x_guesses(end+1) = x_right;
            x_right = x_mid;
        elseif (y_mid*y_right)<0
            % if mid and right are different signs, look for root
            x_guesses(end+1) = x_left;
            x_left = x_mid;
        else
            x_val = NaN;
            return;
        end
        % x_guesses(end+1) = x_mid;
    end

      
    x = NaN;


end