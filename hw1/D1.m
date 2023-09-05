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