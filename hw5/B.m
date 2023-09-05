%Initialize
delta_x = 1;
lambda = @(x) -(2+0.01*x^2);
x = 0:delta_x:15;
y = 0:delta_x:15;
y(1) = 4;
%amount = number of points
amount = (15/delta_x) + 1;

%Exact solution
xx = 0:0.01:15;
f = @(x) 4*exp(-x.^3/300-2*x);
plot(xx, f(xx));
hold on;

%Euler method Y(n+1)=(l+h*lambda)*Y(n)
for i = 1:(amount-1)
  y(i+1) = (1+delta_x*lambda(x(i)))*y(i);
end
plot(x, y)
hold on

%Backward Euler method Y(n+1)=Y(n)/(l-h*lambda)
for i = 1:(amount-1)
  y(i+1) = y(i)/(1-lambda(y(i))*delta_x);
end
plot(x, y)
hold on

%Trapezoidal method Y(n+1)=Y(n)*(l+0.5*h*lambda)/(l-0.5*h*lambda)
for i = 1:(amount-1)
  y(i+1) = y(i)*(1+lambda(x(i))*delta_x/2)/(1-lambda(x(i))*delta_x/2);
end
plot(x, y)
hold on

%Second-order Runge-Kutta Y(n+1)=(1+hl+0.5*(hl)^2)*Y(n)
for i = 1:(amount-1)
  y(i+1) = y(i)*(1+lambda(x(i))*delta_x+(lambda(x(i))*delta_x)^2/2);
end
plot(x, y)
hold on

%Fourth-order Runge-Kutta Y(n+1)=(1+hl+0.5*(hl)^2+(hl)^2/6+(hl)^4/24)*Y(n)
for i = 1:(amount-1)
  y(i+1) = y(i)*(1+lambda(x(i))*delta_x+(lambda(x(i))*delta_x)^2/2+(lambda(x(i))*delta_x)^3/6+(lambda(x(i))*delta_x)^4/24);
end
plot(x, y)
xlim([0 15]);
ylim([-10 10]);
%Plot
title('\delta x=1', 'Fontsize', 20);
xlabel('x', 'Fontsize', 20);
ylabel('y', 'Fontsize', 20);
legend('Exact','Euler','Backward Euler','Trapezoidal','Second-order Runge-Kutta','Fourth-order Runge-Kutta','Fontsize', 15);


