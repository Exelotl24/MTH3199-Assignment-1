close all
clear

% Input given functions
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -0.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
functions = {test_func01, test_derivative01};

% Number of tests/iterations to run
iters = 100;

% Initialize cell arrays
x_bisection_guesses = cell(3, iters);
error = cell(2, iters);

% calculated accurate root
x_root = 0.7174;

figure()

for i = 1:iters
    [~, x_bisection_guesses{1, i}] = bisection_solver(test_func01, randi([-200, floor(x_root)]), randi([ceil(x_root),40]));
    x_bisection_guesses{2, i} = x_bisection_guesses{1, i}(1:end-1);
    x_bisection_guesses{3, i} = x_bisection_guesses{1, i}(2:end);
    
    error{1, i} = x_bisection_guesses{2, i} - x_root;
    error{2, i} = x_bisection_guesses{3, i} - x_root;

    loglog(error{1, i},error{2, i} ,'ro','markerfacecolor','r','markersize',1);
    hold on
end

xlabel("\epsilon_{n}")
ylabel("\epsilon_{n+1}")
title("Bisection Method")