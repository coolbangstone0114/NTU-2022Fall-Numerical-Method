filename= "hw1AB.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
x = rot90(datax);
y = rot90(datay);
n = length(x);
delta_x = x(1,2) - x(1,1); %每個資料點的間隔(因為是均勻分布所以間隔都一樣)
delta_metrix = zeros(n:n); %11*11的矩陣
result_metrix = delta_metrix(:,1); %初始化輸出矩陣
delta_metrix(1,1) = 1;
delta_metrix(n,n) = 1;

for i=1:n-2 %1~9
    delta_metrix(i+1,i) = delta_x/6;
    delta_metrix(i+1,i+1) = 2*delta_x/3;
    delta_metrix(i+1,i+2) = delta_x/6;
end

for i=1:n-2 %從1~9
    result_metrix(i+1,1) = ((y(i+2)-2*y(i+1)+y(i))/delta_x); %因為是freerun out情況，所以頭尾=0，就不對頭尾做改動
end

Second_derivative = (delta_metrix\result_metrix); %利用反矩陣我們便可以得到在freerun out條件下的二次導數值
%用反斜線可以表示反矩陣乘在result_metrix左邊