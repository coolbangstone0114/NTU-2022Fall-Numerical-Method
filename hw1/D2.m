clear
filename= "hw1CD.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
datax = rot90(datax);
datay = rot90(datay);
n = length(datax);
delta_x = zeros(1,n-1);

for i=1:10
    delta_x(1,i) = datax(i+1) - datax(i);
end

delta_metrix = zeros(n:n); %11*11的矩陣
result_metrix = delta_metrix(:,1); %初始化輸之矩陣
delta_metrix(1,1) = 1;
delta_metrix(n,n) = 1;

for i=1:n-2 %1~9
    delta_metrix(i+1,i) = delta_x(1,i)/6;
    delta_metrix(i+1,i+1) = (delta_x(1,i)+delta_x(1,i+1))/3;
    delta_metrix(i+1,i+2) = delta_x(1,i+1)/6;
end

for i=1:n-2 %從1~9
    result_metrix(i+1,1) = (datay(i+2)-datay(i+1))/delta_x(i+1) - (datay(i+1)-datay(i))/delta_x(i); %因為是freerun out情況，所以頭尾=0，就不對頭尾做改動
end

sd = (delta_metrix\result_metrix); %利用反矩陣我們便可以得到在freerun out條件下的二次導數值
%用反斜線可以表示反矩陣乘在result_metrix左邊

%手刻開始
% for i=1:n-1 %從1~10，用C1、C2的算法
%     C1(1:i) = (datay(i+1)-datay(i))/delta_x - (delta_x/6)*(sd(i+1) - sd(i));
%     C2(1:i) = (datay(i)*datax(i+1) - datay(i+1)*datax(i))/delta_x - (delta_x/6)*(datax(i+1)*sd(i) - datax(i)*sd(i+1));
% end

for i=1:n-1
    x(i,:) = linspace(datax(i),datax(i+1),1000);
end
disp(length(x(1,:)))
g = x;

for i=1:n-1 %從1~10，用代入後的算法
    g(i,:) = sd(i)*(((datax(i+1)-x(i,:)).^3)/delta_x(i)-delta_x(i)*(datax(i+1)-x(i,:)))/6;
    g(i,:) = g(i,:) + sd(i+1)*(((x(i,:)-datax(i)).^3)/delta_x(i)-delta_x(i)*(x(i,:)-datax(i)))/6;
    g(i,:) = g(i,:) + datay(i)*(datax(i+1)-x(i,:))/delta_x(i);
    g(i,:) = g(i,:) + datay(i+1)*(x(i,:)-datax(i))/delta_x(i);
end

% for i=1:n-1 %從1~10，用C1、C2的算法
%     g(i,:) = sd(i)*((x(i,:)-datax(i+1)).^3)/(-delta_x*6);
%     g(i,:) = g(i,:) + sd(i+1)*((x(i,:)-datax(i)).^3)/(delta_x*6);
%     g(i,:) = g(i,:) + C1(i)*x(i,:);
%     g(i,:) = g(i,:) + C2(i);
% end

newg = zeros(1:1);
newx = zeros(1:1);
for i=1:n-1 %從1~10
    newg = [newg, g(i,:)];
    newx = [newx, x(i,:)];
end
newg(:,1) = [];
newx(:,1) = [];
  
%繪圖
plot(datax,datay,'x',newx,newg);
set(gca,'FontSize',10);
xlabel("X",'FontSize',15);
ylabel("f(x)",'FontSize',15);
title('Cubic Spline Interpolation Graph','FontSize',25);
legend('Data Points','Cubic Spline','FontSize',15);
grid on;

