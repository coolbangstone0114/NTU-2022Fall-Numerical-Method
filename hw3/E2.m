I_exact = 2.1620386;
I_gauss = 0;
[x,w] = gauss_leg(1,8,9);
f = @(x) log(x)/x;

for i=1:9
    I_gauss = I_gauss + w(i)*f(x(i));
end

error = abs(I_exact - I_gauss);
sprintf("Value of numerical integral : %0.10f", I_gauss)
sprintf("abs of error : %0.10f", error)