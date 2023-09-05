clc
clear

%Initialize
h = 0.001;
t = 0:h:25;
r = 28;

%Assign initial condition
% [x(1,1),y(1,1),z(1,1),x(2,1),y(2,1),z(2,1)] = deal(6);
% y(2,1) = 6.01;
[x(1),y(1),z(1)] = deal(6);
%Construct ODE function
dx = @(t,x,y,z) 10*(y-x);
dy = @(t,x,y,z) r*x-y-x*z;
dz = @(t,x,y,z) x*y-(8/3)*z;

%4th-order Runge-Kutta method
for j=1:2
    if j==2
        y(1) = 6.01;
    end
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
    if j == 1
        x1 = x(1,:);
        y1 = y(1,:);
        z1 = z(1,:);
    end
    if j == 2
        x2 = x(1,:);
        y2 = y(1,:);
        z2 = z(1,:);
        break
    end
end

%plot
figure
plot3(z1, y1, x1,'Color', 'r');
hold on
plot3(z2, y2, x2,'Color', 'g');
grid on
xlabel('z-axis')
ylabel('y-axis')
zlabel('x-axis')
title('3-dimensional xyz space')
hold off

figure
subplot(3,1,1)
plot(t,x1,'r')
hold on
plot(t,x2,'g')
xlabel('t')
ylabel('x')
legend('6','6.01','Location', 'northwest','FontSize', 15);
subplot(3,1,2)
plot(t,y1,'r')
hold on
plot(t,y2,'g')
xlabel('t')
ylabel('y')
subplot(3,1,3)
plot(t,z1,'r')
hold on
plot(t,z2,'g')
xlabel('t')
ylabel('z')

