% bisection_solver finds the roots of a given function starting from two
% guesses by splitting the data in half each time using recursion

function x = bisection_solver(func,x_left,x_right)
    % print_string = num2str(x_left)+', '+ num2str(x_right);
    % disp([x_left, ', ', x_right])

    % calculate x_mid
    x_mid = (x_left+x_right)/2;

    % calculate function for each x value
    y_left = func(x_left);
    y_mid = func(x_mid);
    y_right = func(x_right);

    % define array for bisection roots and values
    bisection_roots = [x_left, x_mid, x_right];
    bisection_values = [y_left, y_mid, y_right];


    location_0 = find(bisection_values==0);

    if ~isempty(location_0)
        % test if any values are roots
        x = bisection_roots(location_0(1));
    % elseif (y_left*y_right)>0
    %     if abs(x_right-x_left)>5
    %         [x_left, x_right]
    %         % if both left and right are same sign but there is a great
    %         % difference then maybe there are two roots
    %         x = [bisection_solver(func, x_left, x_mid), bisection_solver(func, x_mid, x_right)];
    %     else
    %         % if both left and right are same sign then there is no root?
    %         x = NaN;
    %     end
    elseif (y_left*y_mid)<0
        % if left and mid are different signs start recursion
        x = bisection_solver(func, x_left, x_mid);
    elseif (y_mid*y_right)<0
        % if mid and right are different signs, start recursion
        x = bisection_solver(func, x_mid, x_right);
    % elseif (y_left*y_right)>0
    % 
    else
        x = NaN;
        % ran into some other error. throw error
        error('Unknown Error');
    end
    
end