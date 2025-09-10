% bisection_solver finds the roots of a given function starting from two
% guesses by splitting the data in half each time using recursion

function [x, x_guesses] = bisection_solver(func,x_left,x_right)

    tol = 1e-14;
    max_iter = 100;
    iter = 0;
    x_guesses = [];

    while iter < max_iter

        % calculate x_mid
        x_mid = (x_left+x_right)/2;
    
        % calculate function for each x value
        y_left = func(x_left);
        y_mid = func(x_mid);
        y_right = func(x_right);
    
        % x_guesses(end+1) = x_mid;
    
        
        if abs(y_mid)<tol
            % test if any values are roots
            x = x_mid;
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
            x = NaN;
            return;
        end
        % x_guesses(end+1) = x_mid;
    end

      
    x = NaN;


end