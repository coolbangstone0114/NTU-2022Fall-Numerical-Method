clc
clear
%Initialize
h = 0.001;
t = 0:h:25;
r = 28;
%Assign initial condition
[x(1),y(1),z(1)] = deal(1);
%Construct ODE function
dx = @(t,x,y,z) 10*(y-x); 
dy = @(t,x,y,z) r*x-y-x*z;
dz = @(t,x,y,z) x*y-(8/3)*z;

%4th-order Runge-Kutta method
for i=1:(length(t)-1)
    
    xk1 = dx(t(i),x(i),y(i),z(i));
    yk1 = dy(t(i),x(i),y(i),z(i));
    zk1 = dz(t(i),x(i),y(i),z(i));

    xk2=dx((t(i)+h*0.5),(x(i)+0.5*xk1*h),(y(i)+(0.5*yk1*h)),(z(i)+(0.5*zk1*h)));
    yk2=dy((t(i)+h*0.5),(x(i)+0.5*xk1*h),(y(i)+(0.5*yk1*h)),(z(i)+(0.5*zk1*h)));
    zk2=dz((t(i)+h*0.5),(x(i)+0.5*xk1*h),(y(i)+(0.5*yk1*h)),(z(i)+(0.5*zk1*h)));    
    
    xk3=dx((t(i)+h*0.5),(x(i)+0.5*xk2*h),(y(i)+(0.5*yk2*h)),(z(i)+(0.5*zk2*h)));
    yk3=dy((t(i)+h*0.5),(x(i)+0.5*xk2*h),(y(i)+(0.5*yk2*h)),(z(i)+(0.5*zk2*h)));
    zk3=dz((t(i)+h*0.5),(x(i)+0.5*xk2*h),(y(i)+(0.5*yk2*h)),(z(i)+(0.5*zk2*h)));  
    
    xk4=dx(t(i)+h,(x(i)+xk3*h),(y(i)+yk3*h),(z(i)+zk3*h));
    yk4=dy(t(i)+h,(x(i)+xk3*h),(y(i)+yk3*h),(z(i)+zk3*h));
    zk4=dz(t(i)+h,(x(i)+xk3*h),(y(i)+yk3*h),(z(i)+zk3*h));

    x(i+1) = x(i) + h*(xk1+2*xk2+2*xk3+xk4)/6;
    y(i+1) = y(i) + h*(yk1+2*yk2+2*yk3+yk4)/6;
    z(i+1) = z(i) + h*(zk1+2*zk2+2*zk3+zk4)/6;
end

%plot
figure
plot3(z,y,x)
grid on
xlabel('z-axis')
ylabel('y-axis')
zlabel('x-axis')
title('3-dimensional xyz space')

figure
plot(t,x)
title('x versus t')
xlabel('t-axis')
ylabel('x-axis')

figure
plot(t,y)
title('y versus t')
xlabel('t-axis')
ylabel('y-axis')

figure
plot(t,z)
title('z versus t')
xlabel('t-axis')
ylabel('z-axis')

figure
plot(x,y)
title('y versus x')
xlabel('x-axis')
ylabel('y-axis')

figure
plot(x,z)
title('z versus x')
xlabel('x-axis')
ylabel('z-axis')

figure
plot(y,z)
title('z versus y')
xlabel('y-axis')
ylabel('z-axis')
