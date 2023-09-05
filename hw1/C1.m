filename= "hw1CD.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
datax = rot90(datax);
datay = rot90(datay);
n = length(datax);%資料數量 11 個
x = linspace(-1, 1, 20000); %我要帶入的點 一共20000個
L = length(x); %L為所有資料點數量 20000個
y = ones(n, L); %初始化矩陣y，將所有元素設為1

for j=1:n %將xj依序帶入 資料數量1~11
    for i=1:n %資料數量1~11
        if j==i
            continue;
        end
        y(j,:) = y(j,:) .* ((x - datax(i))/(datax(j) - datax(i))); %兩矩陣中的元素一一對應相乘(非矩陣乘法)
    end
end
%繪圖
for k = 1:1:n+1 %從1~12
    subplot(4, 3, k);
    if k==n+1
        plot(x,y);
    end
    plot(x, y(k, :));
    axis([min(x), max(x), min(y(k, :))-1, max(y(k, :))+1]);
    set(gca,'FontSize',10);
    xlabel("X",'FontSize',10);
    ylabel("Lj(x)",'FontSize',10);
    title('Lj(x) Graph','FontSize',15);
    %legend('Lj(x)');
    grid on;
end