function Gx = egg_wrapper_func_x(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    Gx = G(1);
end