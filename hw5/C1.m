clc
clear
h=0.01;
n=1+10/h;
increment=0.005;
N=1+0.9/increment;
F1x=linspace(0.1,1,N);
F2y=linspace(0,0,N);
fl=linspace(0,0,n);
f2=linspace(0,0,n);
f3=linspace(0,0,n);
for i=1:N
  fl(1)=F1x(i);
  for j=2:n
    fl(j)=fl(j) + fl(j-1)*(1-h*f3(j-1)/6);
    fl(j)=fl(j) - fl(j-1)*h*(1-h*f3(j-1)/2)*f3(j-1)/3;
    fl(j)=fl(j) - fl(j-1)*h*(1-h*(1-h*f3(j-1)/2)*f3(j-1)/2)*f3(j-1)/3;
    fl(j)=fl(j) - fl(j-1)*h*(1-h*(1-h*f3(j-1)/2)*f3(j-1)/2)*f3(j-1)*f3(j-1)/6;
    f2(j)=f2(j) + f2(j-1)+h*fl(j)/6+h*(fl(j-1)+fl(j))/3+h*fl(j)/6;
    f3(j)=f3(j) + f3(j-1)+h*f2(j)/6+h*(f2(j-1)+f2(j))/3+h*f2(j)/6;
  end
  F2y(i)=f2(n);
  for j=1:n
    fl(j)=0;
    f2(j)=0;
    f3(j)=0;
  end
end
plot(F1x,F2y);
xlim([0 1]);
ylim([0 2]);
xlabel('f1(0)');
ylabel('f2(10)');
grid on;
set(gca,'fontsize',15);