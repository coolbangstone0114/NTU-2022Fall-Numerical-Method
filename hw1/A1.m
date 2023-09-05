filename= "hw1AB.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
n = length(datax); %資料數量 11 個
datax = rot90(datax); %將兩讀取矩陣轉90度
datay = rot90(datay);

x = linspace(-1, 1, 20000); %我要帶入的點 一共20000個
L = length(x); %L為所有資料點數量 20000個
y = ones(n, L); %初始化矩陣y，將所有元素設為1

for j=1:n %將xj依序帶入 資料數量1~11
    for i=1:n %資料數量1~11
        if j==i %當xi = xj時跳過一次迴圈
            continue;
        end
        y(j,:) = y(j,:) .* ((x - datax(i))/(datax(j) - datax(i))); %兩矩陣中的元素一一對應相乘(非矩陣乘法)
    end
end

%繪圖
for k = 1:1:n+1 %從1~12 將版面分成4*3的矩陣印出12張圖
    subplot(4, 3, k);
    if k==n+1
        plot(x,y); %最後一張圖為前面11張圖的疊合
    end
    plot(x, y(k, :));
    axis([min(x), max(x), min(y(k, :))-1, max(y(k, :))+1]);
    set(gca,'FontSize',10);
    xlabel("X",'FontSize',10);
    ylabel("Lj(x)",'FontSize',10);
    title('Lj(x) Graph','FontSize',15);
    grid on;
end