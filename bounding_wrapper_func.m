function value = bounding_wrapper_func(x0, y0, theta, egg_params, y_ground, x_wall, desired_value)
    [~, xmax, ymin, ~] = find_bounding_box(x0,y0,theta,egg_params);
    if desired_value == 'x'
        value = xmax-x_wall;
    elseif desired_value == 'y'
        value = ymin-y_ground;
    else
        value = NaN;
    end
end