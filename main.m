
close all
clear

% ----------------- defining all functions -------------------------------

syms x

test_func01 = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -0.7 - exp(x/6);
test_derivative01 = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
functions01= [test_func01, test_derivative01];

test_func02 = (x-30.879).^2;
test_derivative02 = diff(test_func02);
functions02 = [test_func02, test_derivative02];

test_func03 = 8.3*exp((x-27.3)/2)./(1+exp((x-27.3)/2))-3;
test_derivative03 = diff(test_func03);
functions03 = [test_func03, test_derivative03];


% ------------------------------------------------------------------------

% --------------- CONVERGENCE ANALYSIS -----------------------------------
filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];

x_root_base = fzero(matlabFunction(test_func01, 'Vars', x),0);

x_guess0 = 0;
num_guesses = 1000;
A = 2;

x_guesslist1 = -2*A*(rand(1,num_guesses))+x_root_base;
x_guesslist2 = 2*A*(rand(1,num_guesses))+x_root_base;

convergence_analysis(1, test_func01, x_guess0, x_guesslist1, x_guesslist2, filter_list)
convergence_analysis(2, test_func01, x_guess0, x_guesslist1, x_guesslist2, filter_list)
convergence_analysis(3, test_func01, x_guess0, x_guesslist1, x_guesslist2, filter_list)
convergence_analysis(4, test_func01, x_guess0, x_guesslist1, x_guesslist2, filter_list)


% -------------------- CONVERGENCE GRAPHING ------------------------------

x_newton_guesses = linspace(0, 50, 200);

convergence_graph(2, functions03(1), x_newton_guesses, x_newton_guesses)

x_bisection_guesses1 = linspace(0, 50, 200);
x_bisection_guesses2 = linspace(50, 0, 200);

convergence_graph(1, functions03(1), x_bisection_guesses1, x_bisection_guesses2)


convergence_graph(3, functions03(1), x_bisection_guesses1, x_bisection_guesses2)


convergence_graph(4, functions03(1), x_bisection_guesses1, x_bisection_guesses2)
