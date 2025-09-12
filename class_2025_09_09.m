function class_2025_09_09()
%     dfdx = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x./2+6) -0.7 - exp(x./6);
    x_in = linspace(0,50,200);
    [fvals, dfdx_vals] = test_function03(x_in);

    dxtol = 1e-14;
    ytol = 1e-14;
    dfdxmin = 1e-10;
    max_iter = 100;

    a = 27.3; b = 2; c = 8.3; d = -3;
    H = @(x) exp((x-a)/b);
    dH = @(x) H/b;
    L = @(x) 1+H;
    dL = @(x) dH;
    f_val = @(x) c.*H./L+d;
    dfdx = @(x) c.*(L.*dH-H.*dL)./(L.^2);

    x_root = newton_solver({f_val, dfdx}, 27);

    success_list = [];
    fail_list = [];


    for n = 1:length(x_in)
        x_guess = g_in(n);
        root_attempt = origin_newton(@test_function,x_guess, dxtol, ytol, max_iter, dfdxmin);
       
    if abs(x_root - root_attempt) < .1
        success_list(end+1) = x_guess;

    else
        fail_list(end+1) = x_guess;
    end

end

hold on

[f_success , ~] = test_function(success_list);
[f_fail , ~] = test_function(fail_list);

plot(x_in, fvals, 'k', 'linewidth',2);
plot([x_in(1),x_in(end), [0,0] 'b--', 'linewidth', 1]);
plot(success_list, f_success, 'ro', ',markerfacecolor', 'r', 'markersize', 3);
plot(fail_list, f_fail, 'ro', ',markerfacecolor', 'r', 'markersize', 3);
