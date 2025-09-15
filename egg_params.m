function egg_params()

    %set the oval hyper-parameters
    egg_params = struct();
    egg_params.a = .3; egg_params.b = .2; egg_params.c = 1.5;

    %specify the position and orientation of the egg
    x0 = 5; y0 = 5; theta = pi/6;
%x and y change pos, theta changes orientation of egg
    s = .3;
    %set up the axis
    hold on; axis equal; axis square
    axis([4,6,4,6])

    s_perimeter = linspace(0, 1, 100);

    s_tangent = .3; % arbitrarily form 0-1  
    [V_vals, G_vals] = egg_func(s_perimeter,x0,y0,theta,egg_params);


    plot(V_vals(1,:), V_vals(2,:), 'k', 'linewidth', 2);

end