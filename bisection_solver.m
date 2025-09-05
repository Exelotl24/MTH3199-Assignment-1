% bisection_solver finds the roots of a given function starting from two
% guesses by splitting the data in half each time using recursion

function x = bisection_solver(func,x_left,x_right)

    % calculate x_mid
    x_mid = (x_left+x_right)/2;

    % calculate function for each x value
    y_left = func(x_left);
    y_mid = func(x_mid);
    y_right = func(x_right);

    
    if abs(y_mid)<1e-6
        % test if any values are roots
        x = x_mid;
        return;
    end

    if (y_left*y_mid)<0
        % if left and mid are different signs, look for root
        x = bisection_solver(func, x_left, x_mid);
    elseif (y_mid*y_right)<0
        % if mid and right are different signs, look for root
        x = bisection_solver(func, x_mid, x_right);
    else
        x = NaN;
    end
    
    
end