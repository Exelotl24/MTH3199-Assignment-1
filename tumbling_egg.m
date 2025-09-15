close all
clear

syms x

t = 0:0.01:2;

%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;

% define egg initial conditions (starting point & speeds)
g = 9.8;
y0 = 6;
x0 = 0;
y0_speed = 5;
x0_speed = 7;
theta_0 = 0;
omega = 4;

% define egg trajectory function
y_t = -1./2.*g*t.^2+y0_speed.*t+y0;
x_t = x0_speed.*t+x0;
theta_t = omega.*t+theta_0;

% define wall distance
wall_dist = 10;



figure()
plot(x_t, y_t, 'k--');
xlim([0, 10])
ylim([0, 10])
title("Traj-EGG-tory")
hold on


egg_params()
plot(V_vals(1,:), V_vals(2,:), 'k', 'linewidth', 2);

animation = plot(x0, y0, 'ro');


pause(1)

% at each moment in time, look at egg
for i = 1:length(t)

    % where is the egg?
    x = x_t(i);
    y = y_t(i);
    theta = theta_t(i);

    set(animation, 'XData', x, 'YData', y, 'Marker', 'o', 'MarkerFaceColor','b')
    drawnow;

    % find the bounding box
    [xmin, xmax,ymin,ymax] = find_bounding_box(x,y,theta,egg_params);

    % plot egg and bounding box
    xline(xmin)
    xline(xmax)
    yline(ymin)
    yline(ymax)

    % is bounding box in contact with wall or ground?
    if abs(ymin)< tol
        break;
    elseif abs(xmax)<tol
        break;
    end

    pause(t(end)/length(t))

end
