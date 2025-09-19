function convergence_graph(solver_flag, fun, guess_list1, guess_list2)

    % initialize symbolic variable
    syms x

    % calculate derivative function
    dfdx = diff(fun);

    % Make sure function can be called
    fun_eval = matlabFunction(fun, 'Vars', x);
    dfdx_eval = matlabFunction(dfdx, 'Vars', x);

    % package functions
    functions = [fun, dfdx];

    % initialize lise of converging and non convering guesses
    converging_x = [];
    non_converging_x = [];
    
    
    for i = 1:length(guess_list1)

        % call each funciton based on the solver flag
        switch solver_flag
            case 1
                % bisection
                [x, ~] = bisection_solver(fun, guess_list1(i), guess_list2(i));
                method_title = "Bisection Method";
            case 2
                % newton
                [x, ~] = newton_solver(functions, guess_list1(i));
                method_title = "Newton Method";
            case 3
                % secant
                [x, ~] = secant_solver(fun, guess_list1(i), guess_list2(i));
                method_title = "Secant Method";
            case 4
                % fzero
                [x, ~] = my_fzero(fun_eval, guess_list1(i));
                method_title = "fzero method";
        end
        
        % if the returned value is within tolerance of the root, add to
        % converging list. otherwise, add it to non-converging
        if abs(fun_eval(x)) < 1e-6
            converging_x(end+1) = guess_list1(i);
        else
            non_converging_x(end+1) = guess_list1(i);
        end
    
    end
    
    
    % plot the converging and non-converging plots
    figure()
    fplot(fun, [guess_list1(1), guess_list2(end)])
    hold on
    plot(converging_x, fun_eval(converging_x), 'go')
    plot(non_converging_x, fun_eval(non_converging_x), 'ro')
    yline(0, "k-")
    title(["Test Function Convergence", method_title])
    ylabel("f(x)")
    xlabel("x")

    
end