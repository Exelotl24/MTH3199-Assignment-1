function secant_method(fun, x0, x1, tol, iter)

for i = 1:iter
      x2 = x1 - fun(x1)*(x1 - x0)/(fun(x1) - fun(x0));

      if abs(fun(x2)) < tol
          disp(['Root x2', num2str(x2), num2str(i)]);
          return
      end