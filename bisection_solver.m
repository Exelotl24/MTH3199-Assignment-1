% bisection_solver finds the roots of a given function starting from two
% guesses by splitting the data in half each time using recursion

function x = bisection_solver(func,x_left,x_right)


    % calculate x_mid
    x_mid = (x_left+x_right)/2;

    % calculate function for each x value
    y_left = func(x_left);
    y_mid = func(x_mid);
    y_right = func(x_right);

    % define array for bisection roots and values
    bisection_roots = [x_left, x_mid, x_right];
    bisection_values = [y_left, y_mid, y_right];

    location_0 = find(abs(bisection_values)<0.001);

    x = [];

    if ~isempty(location_0)
        % test if any values are roots
        x = bisection_roots(location_0(1));
    
    end

    if abs(x_left-x_right)<0.0000001
        % if x_left and x_right are too similar, call there is no root
        % there
        x = [x, NaN];
        return;
        % % ran into some other error. throw error
        % error('Unknown Error');
    end


    if (y_left*y_mid)<0
        % if left and mid are different signs, look for root
        x = [x, bisection_solver(func, x_left, x_mid)];
    end
    if (y_mid*y_right)<0
        % if mid and right are different signs, look for root
        x = [x, bisection_solver(func, x_mid, x_right)];

    end
    
    
end