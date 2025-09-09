
close all
clear
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -0.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

x_guess0 = 0;
x_guesslist1 = randi([-300 x_guess0],1,100);
x_guesslist2 = randi([x_guess0 30],1,100);
filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];


convergence_analysis(2, test_func01, x_guess0, x_guesslist1, x_guesslist2, filter_list)

return;

% test_func01 = @(x) x.^2-2;
% test_derivative01 = @(x) 2*x;

functions = {test_func01, test_derivative01};

% [x, x_newton_guesses] = newton_solver(functions, 40);

% [x, x_secant_guesses] = secant_solver(test_func01, 0, 4);


x_left = -15;
x_right = 40;
[x, x_bisection_guesses] = bisection_solver(test_func01, x_left, x_right);



figure()
fplot(test_func01, [x_left, x_right])
hold on
yline(0, '--k')
plot(x, test_func01(x), "rx")
xlabel("x-axis")
ylabel("y-axis")