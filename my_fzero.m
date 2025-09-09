function [x, x_hist] = my_fzero(fun, x0)
    % Store history in a persistent array
    persistent x_history
    x_history = [];

    % Wrapped function to log guesses
    function y = wrapped_fun(x)
        x_history(end+1) = x;   %#ok<AGROW>
        y = fun(x);
    end

    % Call fzero with wrapped function
    x = fzero(@wrapped_fun, x0);

    % Return the history
    x_hist = x_history;
end