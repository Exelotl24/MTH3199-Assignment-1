%start with newton function orion_newton
% function class_2025_09_12()
close all
clear
    eggxample01();
% end

%template for how to properly call egg_func
%also provides example for how to interpret outputs
function eggxample01()

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
    [V_tangent, G_tangent] = egg_func(s_tangent,x0,y0,theta,egg_params);
%      plot(V_vals(1,:), V_vals(2,:), 'ro', 'markerfacecolor','r', 'markersize', 4);
%      plot(V_tangent(1), G_tangent(2), 'ro', 'markerfacecolor','r', 'markersize', 4);
    % plot(V_tangent(1)+[0,G_tangent(1)],V_tangent(2)+[0,G_tangent(2)] k', 'linewidth', 2);

    [xmin,xmax,ymin,ymax] = find_bounding_box(x0,y0,theta,egg_params);
    plot([xmin,xmax,xmax,xmin],[ymin,ymax,ymax,ymin]);
end


function [xmin, xmax,ymin,ymax] = find_bounding_box(x0,y0,theta,egg_params)

    egg_wrapper_func2_y = @(s_in) egg_wrapper_func1_y(s,x0,y0,theta,egg_params);
    egg_wrapper_func2_x = @(s_in) egg_wrapper_func1_x(s,x0,y0,theta,egg_params);

    s_guess_list = 0:.2:1;

    dxtol = 1e-14; ytol = 1e-14; max_iter = 200; dfdxmin = 1e-8;

    x_list = [];
    y_list = [];
    for s_guess = s_guess_list
        s_rootx = secant_solver(egg_wrapper_func2_x, s_guess+1e-4, dxtol,ytol,max_iter,dfdxmin)
        [V, ~] = egg_func(s_rootx,x0,y0,theta,egg_params);
        x_list(end+1) = V(1);

        s_rooty = secant_solver(egg_wrapper_func2_y, s_guess+1e-4, dxtol,ytol,max_iter,dfdxmin)
        [V, ~] = egg_func(s_rooty,x0,y0,theta,egg_params);
        y_list(end+1) = V(2);

    end

        xmin = min(x_list);
        xmax = max(x_list);
        ymin = min(y_list);
        ymax = max(y_list);
end


function Gx = egg_wrapper_func1_x(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    Gx = G(1);
end

function Gy = egg_wrapper_func1_y(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    Gy = G(2);
end


function [V, G] = egg_func(s,x0,y0,theta,egg_params)
        %unpack the struct
        a=egg_params.a;
        b=egg_params.b;
        c=egg_params.c;
        %compute x (without rotation or translation)
        x = a*cos(2*pi*s);
        %useful intermediate variable
        f = exp(-c*x/2);
        %compute y (without rotation or translation)
        y = b*sin(2*pi*s).*f;
        %compute the derivatives of x and y (without rotation or translation)
        dx = -2*pi*a*sin(2*pi*s);
        df = (-c/2)*f.*dx;
        dy = 2*pi*b*cos(2*pi*s).*f + b*sin(2*pi*s).*df;
        %rotation matrix corresponding to theta
        R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
        %compute position and gradient for rotated + translated oval
        V = R*[x;y]+[x0*ones(1,length(theta));y0*ones(1,length(theta))];
        G = R*[dx;dy];
end


function x_root = secant_solver(fun,x_guess0, x_guess1, dxtol, ytol, max_iter, dfdxmin)

    delta_x = 2*dxtol;

    fval0 = fun(x_guess0);
    fval1 = fun(x_guess1);

    dfdx = (fval1 - fval0)/(x_guess1 - x_guess0);

    count = 0;


    while count<max_iter && abs(delta_x) > dxtol && abs(fval1) > ytol && abs(dfdx) > dfdxmin

    count = count+1;

    delta_x = -fvals/dfdx;

    x_guess2 = x_guess1 + delta_x;
    fval2 = fun(x_guess1);

    x_guess0 = x_guess1;
    fval0 = fval1;

    x_guess1 = x_guess2;
    fval1 = fval2;

    dfdx = (fval1-fval0)/(x_guess1 - x_guess0);


    end

    x_root = g_guess;

end

