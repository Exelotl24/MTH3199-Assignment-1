close all
clear

%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 0.3; egg_params.b = 0.2; egg_params.c = 1.5;

% define egg initial conditions (starting point & speeds)
g = 9.8;
y0 = 6; x0 = 0; theta_0 = 0;
y0_speed = 5; x0_speed = 7; omega = 8*pi;
tol = 1e-6;

% define egg trajectory function
syms t
y_t = -1./2.*g*t.^2+y0_speed.*t+y0;
x_t = x0_speed.*t+x0;
theta_t = omega.*t+theta_0;
traj_func = [x_t, y_t, theta_t];

% define end points
x_wall = 10;
y_ground = 0;

% need to find t = ? when x = wall_dist and when y = y_ground
[t_ground,t_wall] = collision_func(traj_func, egg_params, y_ground, x_wall)

egg_animation(traj_func, [x0, y0, theta_0], min(t_ground, t_wall), egg_params, y_ground, x_wall)
