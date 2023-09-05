filename= "hw1CD.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
datax = rot90(datax);
datay = rot90(datay);
n = length(datax);%資料數量 11 個
x = linspace(-1, 1, 20000); %我要帶入的點
L = length(x);%L為所有資料點數量 500個
y = ones(n, L);

for j=1:n %將xj依序帶入 資料數量1~11
    for i=1:n %資料數量1~11
        if j==i
            continue;
        end
        y(j,:) = y(j,:) .* ((x - datax(i))/(datax(j) - datax(i)));
    end
    y(j,:) = y(j,:)*datay(j);
end

z = sum(y);
%繪圖
plot(datax,datay,'x', x, z(1, :));
axis([min(x), max(x), min(z(1, :))-0.4, max(z(1, :))+0.4]);
set(gca,'FontSize',10);
xlabel("X",'FontSize',15);
ylabel("P(x)",'FontSize',15);
title('Lagrange Interpolation Graph','FontSize',25);
legend('Data Points','Interpolation Polynominal','FontSize',15);
grid on;