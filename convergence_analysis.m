%Example template for analysis function
%INPUTS:
%solver_flag: an integer from 1-4 indicating which solver to use
% 1->Bisection 2-> Newton 3->Secant 4->fzero
%fun: the mathematical function that we are using the
% solver to compute the root of
%x_guess0: the initial guess used to compute x_root
%guess_list1: a list of initial guesses for each trial
%guess_list2: a second list of initial guesses for each trial
% if guess_list2 is not needed, then set to zero in input
%filter_list: a list of constants used to filter the collected data
function convergence_analysis(solver_flag, fun, ...
x_guess0, guess_list1, guess_list2, filter_list)

    close all
    clear

    tol = 1e-6;

    

end