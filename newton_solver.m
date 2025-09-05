%Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
function x = newton_solver(fun,derfun,xn,tol)
%Definition of the test function and its derivative
% test_func01 = @(x) (x.ˆ3)/100 - (x.ˆ2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
% test_derivative01 = @(x) 3*(x.ˆ2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
while abs(fun(xn)) > tol
xn = xn - (fun(xn)/derfun(xn));
end

disp(['Root','xn', num2str(xn), 'f(x)', num2str(fun(xn))]);
end