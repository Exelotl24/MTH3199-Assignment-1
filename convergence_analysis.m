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
function convergence_analysis(solver_flag, fun, x_guess0, guess_list1, guess_list2, filter_list)

    close all

    syms x
    dfdx = diff(fun, x);
    f_handle   = matlabFunction(fun, 'Vars', x);
    dfdx_handle = matlabFunction(dfdx, 'Vars', x);
    functions = {f_handle, dfdx_handle};

    % Number of tests/iterations to run
    iters = 100;

    % Initialize cell arrays
    x_guesses = cell(iters);
    error = cell(2, iters);
    X_regression = [];
    Y_regression = [];


    for i = 1:iters


        switch solver_flag
            case 1
                % bisection
                [x, x_guesses{i}] = bisection_solver(fun, randi([-200, floor(x_guess0)]), randi([ceil(x_guess0),40]));
            case 2
                % newton
                [x, x_guesses{i}] = newton_solver(functions, x_guess0);
            case 3
                % secant
                [x, x_guesses{i}] = secant_solver(fun, 0, 4);
            case 4
                % fzero
    
        end

        
        
        error{1, i} = x_guesses{i}(1:end-1) - x;
        error{2, i} = x_guesses{i}(2:end) - x;
    
        loglog(error{1, i},error{2, i} ,'ro','markerfacecolor','r','markersize',1);
        hold on
        
        % Filter Data
        %iterate through the collected data
        for n=1:length(error{1, i})
            %if the error is not too big or too small
            %and it was enough iterations into the trial...
            if error{1, i}(n)>1e-15 && error{1, i}(n)<1e-2 && ...
            error{2, i}(n)>1e-14 && error{2, i}(n)<1e-2 && ...
            n>2
                %then add it to the set of points for regression
                X_regression(end+1) = error{1, i}(n);
                Y_regression(end+1) = error{2, i}(n);
            end
        end
        
    end

    loglog(X_regression,Y_regression ,'bo','markerfacecolor','b','markersize',1);

    [p, k] = generate_error_fit(X_regression, Y_regression)
    %generate x data on a logarithmic range
    fit_line_x = 10.^[-16:.01:1];
    %compute the corresponding y values
    fit_line_y = k*fit_line_x.^p;
    %plot on a loglog plot.
    loglog(fit_line_x,fit_line_y,'k-','linewidth',2)
    
    
    xlabel("\epsilon_{n}")
    ylabel("\epsilon_{n+1}")

end