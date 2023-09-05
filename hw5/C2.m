clear

N = 1000;
iter = 8;
f = @(t, y) [-y(1)*y(3); y(1); y(2)];
[t y1] = rk4(f, [0 10], [1 0 0],N);
[t y2] = rk4(f, [0 10], [.5 0 0],N);
f1a = .5;
f1b = 1;
f2a = y2(2, end);
f2b = y1(2, end);
tol = 0.00001;

for i=1:iter
    f1new = f1a + (f1a-f1b)/(f2a-f2b)*(1-f2a);
    [t y] = rk4(f,[0 10],[f1new 0 0],N);
    fprintf('iter: %2d, f1(0)=%17.15f, f2(10)=%17.15f\n',i,f1new, y(2,end));
    if (abs(y(2, end)-1) <= tol)
        break;
    endif
    f1b = f1a;
    f1a = f1new;
    f2b = f2a;
    f2a = y(2,end);
endfor
plot(t, y2);
grid on
axis([0 6 0 2]);
legend('f_1','f_2', 'f_3');
xlabel('\eta', 'FontSize',14);
set (gca, 'fontsize',15);

function [t,y] = rk4(f,tspan,y0,N)
%Fourth-order Runge-Kutta
    m = length(y0);
    t = linspace(tspan(1),tspan(2),N+1);
    y = zeros(m, N+1);
    h = (tspan(2)-tspan(1))/N;
    y(:,1) = y0;
    for i = 1:N
        k1=h*f(t(i),y(:,i));
        k2=h*f(t(i)+h/2,y(:,i)+k1/2);
        k3=h*f(t(i)+h/2,y(:,i)+k2/2);
        k4=h*f(t(i)+h,y(:,i)+k3);
        y(:,i+1)=y(:,i)+k1/6+ (k2+k3)/3 + k4/6;
    endfor
endfunction
