clear
I_exact = 2.1620386;
points = 9;
x = linspace(1,8,points);
delta_x = x(2) - x(1);
% Function
f = @(x) log(x)/x;
%Simpson's rule
Is = 0;
for i=1:4
    Is = Is + (delta_x/3)*( f(x(2*i-1)) + 4*f(x(2*i)) + f(x(2*i+1)) );
end
sprintf("Value of numerical integral : %0.10f", Is)
% abs of error
error = abs(I_exact - Is);
sprintf("abs of error : %0.10f", error)