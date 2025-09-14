function Gy = egg_wrapper_func_y(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    Gy = G(2);
end