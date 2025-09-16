%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
% of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground
%x_wall: position of the wall
%OUTPUTS:
%t_ground: time that the egg would hit the ground
%t_wall: time that the egg would hit the wall
function [t_ground,t_wall] = collision_func(traj_func, egg_params, y_ground, x_wall)

    syms t

    if isa(traj_func(1), 'sym')
        x_fun = matlabFunction(traj_func(1), 'Vars', t);
        y_fun = matlabFunction(traj_func(2), 'Vars', t);
        theta_fun = matlabFunction(traj_func(3), 'Vars', t);
    else
        x_fun = traj_func(1);
        y_fun = traj_func(2);
        theta_fun = traj_func(3);
    end

    bounding_box_x = @(x) bounding_wrapper_func(x_fun(x), y_fun(x), theta_fun(x), egg_params, y_ground, x_wall, 'x');
    bounding_box_y = @(x) bounding_wrapper_func(x_fun(x), y_fun(x), theta_fun(x), egg_params, y_ground, x_wall, 'y');
    t_ground = secant_solver(bounding_box_x, 0, 2);
    t_wall = secant_solver(bounding_box_y, 0, 2);

    
end