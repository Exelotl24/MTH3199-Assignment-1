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

    method_title = "";

    syms x
    dfdx = matlabFunction(diff(fun, x), 'Vars', x);
    functions = {matlabFunction(fun), dfdx};

    iters = length(guess_list1);

    % Initialize cell arrays
    x_guesses = cell(iters);
    error = cell(2, iters);
    X_regression = [];
    Y_regression = [];

    x_root = fzero(functions{1}, x_guess0);
    [x_root, ~] = newton_solver(functions, 30);


    figure()
    for i = 1:iters

        switch solver_flag
            case 1
                % bisection
                [~, x_guesses{i}] = bisection_solver(fun, guess_list1(i), guess_list2(i));
                method_title = "Bisection Method";
            case 2
                % newton
                [~, x_guesses{i}] = newton_solver(functions, guess_list1(i));
                method_title = "Newton Method";
            case 3
                % secant
                [~, x_guesses{i}] = secant_solver(fun, guess_list1(i), guess_list2(i));
                method_title = "Secant Method";
            case 4
                % fzero
                [~, x_guesses{i}] = my_fzero(fun, guess_list1(i));
                method_title = "fzero method";
        end
        
        
        error{1, i} = abs(x_guesses{i}(1:end-1) - x_root);
        error{2, i} = abs(x_guesses{i}(2:end) - x_root);
    
        loglog(error{1, i},error{2, i} ,'ro','markerfacecolor','r','markersize',2);

        hold on
        
        % Filter Data
        %iterate through the collected data
        for n=1:length(error{1, i})
            %if the error is not too big or too small
            %and it was enough iterations into the trial...
            if error{1, i}(n)>filter_list(1) && error{1, i}(n)<filter_list(2) && ...
            error{2, i}(n)>filter_list(3) && error{2, i}(n)<filter_list(4) && ...
            n>filter_list(5)
                %then add it to the set of points for regression
                X_regression(end+1) = error{1, i}(n);
                Y_regression(end+1) = error{2, i}(n);
            end
        end
        
    end

    loglog(X_regression,Y_regression ,'bo','markerfacecolor','b','markersize',2);

    [p, k] = generate_error_fit(X_regression, Y_regression)
    

    %generate x data on a logarithmic range
    fit_line_x = 10.^[-16:.01:1];
    %compute the corresponding y values
    fit_line_y = k*fit_line_x.^p;
    %plot on a loglog plot.
    loglog(fit_line_x,fit_line_y,'k-','linewidth',1)

    xlim([1e-20, 1e4])
    ylim([1e-20, 1e4])
    xlabel("\epsilon_{n}")
    ylabel("\epsilon_{n+1}")
    title(method_title)

    [newton_dfdx,newton_d2fdx2] = approximate_derivative(functions{1},x_root);
    newton_k = abs(newton_d2fdx2/(2*newton_dfdx))

end