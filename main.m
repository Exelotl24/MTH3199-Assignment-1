
close all
clear
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -0.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;


% test_func01 = @(x) x.^2-2;
% test_derivative01 = @(x) 2*x;

functions = {test_func01, test_derivative01};

x = newton_solver(functions, 40);

x_left = -15;
x_right = 40;
% x = bisection_solver(test_func01, x_left, x_right);



figure()
fplot(test_func01, [x_left, x_right])
hold on
yline(0, '--k')
plot(x, test_func01(x), "rx")
xlabel("x-axis")
ylabel("y-axis")