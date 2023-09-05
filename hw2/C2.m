clear
xj = linspace(0, 3, 15); %我要帶入的grid points從x0~x14
space = xj(2) - xj(1);
yj = sin(5*xj); %f0~f14
L = length(xj);
%初始化矩陣A
A = zeros(L,L);
%初始化邊界微分組合之係數
A(1,1) = 1;
A(1,2) = 2;
A(L,L) = 1;
A(L,L-1) = 2;
%初始化一般微分組合之係數
for i=2:L-1
    A(i,i-1) = 1;
    A(i,i) = 4;
    A(i,i+1) = 1;
end
%初始化矩陣B
B = zeros(L,1);
%設定邊界條件
B(1,1) = (-5/2)*yj(1) + 2*yj(2) + (1/2)*yj(3);
B(L,1) = (5/2)*yj(L) - 2*yj(L-1) - (1/2)*yj(L-2);
%設定一般條件
for i=2:L-1
    B(i,1) = 3*(yj(i+1) - yj(i-1));
end
B = (1/space)*B;
%利用反矩陣便可求得一次微分
fd = (A\B);
%真實微分
x = linspace(0,3,20000);
yfx = 5*cos(5*x);
yf = 5*cos(5*xj);
%繪圖
figure(1);clf
plot(xj,fd,'k.--','MarkerSize',20);
hold on;
%plot(xj,yf);
plot(x,yfx);
xlabel('x','Fontsize',14)
ylabel('Derivative','Fontsize',14)
title('4th Order Pade Differentiation','Fontsize',14)
legend('Computed Derivative','Exact Derivative');
grid on;