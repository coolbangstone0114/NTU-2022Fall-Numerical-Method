clear
filename= "hw1E.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
datax = rot90(datax);%將兩讀取矩陣轉90度
datay = rot90(datay);
n = length(datax); %data數量，總共11個
x = linspace(0, 2*pi, 500);
a = 1:0.001:2; %用來trial and error的a值
na = length(a); % trial and error的a值數量
test_y = zeros(na:n); %初始化矩陣，用於存放trial and error得出的函數值(大小為na*n)

for i=1:na %將向量a的值帶入公式遍歷一次
    test_y(i,:) =  a(i)*cos(datax)+3.6*sin(2*datax);
    error_y(i,:) = datay - test_y(i,:);
end

error_y = abs(error_y);
errorSum_y = sum(error_y');
[M, I] = min(errorSum_y); %回傳向量中的最小值到 M，最小值對應的index到 I
disp(M)
disp(I)
disp(a(I)) %此index對應之 x 值，可知所求 a 值為1.2

% %印出Trial and Error結果，如要印出觀察結果的話 uncomment 25~28行即可
% plot(a, errorSum_y);
% xlabel("a",'FontSize',15);
% ylabel("Absolute Value of Error Sum",'FontSize',15);
% title('Trail and Error of value "a"','FontSize',25);

%印出插植函數結果
y =  a(I)*cos(x)+3.6*sin(2*x);
plot(datax, datay,'x',x, y);
xlabel("X",'FontSize',15);
ylabel("f(x)",'FontSize',15);
title('Lagrange Interpolation Function','FontSize',25);
legend('Data Points','f(x)','FontSize',15);