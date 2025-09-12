
close all
clear

syms x

test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -0.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

x_root_base = fzero(test_func01,0);

x_guess0 = 0;
% x_guesslist1 = randi([-300 x_guess0],1,100);
% x_guesslist2 = randi([x_guess0 30],1,100);

num_guesses = 1000;
A = 2;
% x_guesslist1 = 2*A*(rand(1,num_guesses)-.5)+x_root_base;
% x_guesslist2 = 2*A*(rand(1,num_guesses)-.5)+x_root_base;

x_guesslist1 = -2*A*(rand(1,num_guesses))+x_root_base;
x_guesslist2 = 2*A*(rand(1,num_guesses))+x_root_base;

filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
% convergence_analysis(2, test_func01, x_guess0, x_guesslist1, x_guesslist2, filter_list)


test_func02 = (x-30.879).^2;
test_derivative02 = diff(test_func02);

functions02 = {matlabFunction(test_func02), matlabFunction(test_derivative02)};
newton_solver(functions02, 37)
convergence_analysis(2, test_func02, 30, 0:1:100, 0:1:100, filter_list)


test_func03 = 8.3*exp((x-27.3)/2)./(1+exp((x-27.3)/2))-3;
test_derivative03 = diff(test_func03);
functions03 = {matlabFunction(test_func03), matlabFunction(test_derivative03)};


figure()
fplot(test_func03)
xlim([0, 50])
ylim([-8, 8])
yline(0, 'k--')


newton_solver(functions03, -15)
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