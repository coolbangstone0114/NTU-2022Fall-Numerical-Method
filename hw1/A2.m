filename= "hw1AB.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
datax = rot90(datax);%將兩讀取矩陣轉90度
datay = rot90(datay);
n = length(datax); %資料數量 11 個
x = linspace(-1, 1, 20000); %我要帶入的點
L = length(x); %L為所有資料點數量 20000 個
y = ones(n, L);%初始化矩陣y，將所有元素設為1

for j=1:n %將xj依序帶入 資料數量1~11
    for i=1:n %資料數量1~11
        if j==i %當xi = xj時跳過一次迴圈
            continue;
        end
        y(j,:) = y(j,:) .* ((x - datax(i))/(datax(j) - datax(i))); 
        %兩矩陣中的元素一一對應相乘(非矩陣乘法)
    end
    y(j,:) = y(j,:)*datay(j); %乘上對應的datay
end

z = sum(y); %將所有拉格朗日多項式的值相加(如公式中的Sigma之功用)

%繪圖
plot(datax,datay,'x',x, z(1, :));
set(gca,'FontSize',10);
xlabel("X",'FontSize',15);
ylabel("P(x)",'FontSize',15);
title('Lagrange Interpolation Graph','FontSize',25);
%legend('Interpolation polynominal','FontSize',15);
grid on;