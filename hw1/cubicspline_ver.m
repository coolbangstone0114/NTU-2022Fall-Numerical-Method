filename= "hw1CD.dat";
[datax, datay] = textread(filename, "%f %f", 'headerlines', 1);
datax = rot90(datax);
datay = rot90(datay);
cs = spline(datax,[0 datay 0]);
xx = linspace(-1, 1, 10000); %取 10000 個等間隔數據點
%繪圖
plot(datax,datay,'x',xx,ppval(cs,xx),'-');
%axis([min(datax), max(datax), min(datay)-0.1, max(datay)+0.1]);
set(gca,'FontSize',10);
xlabel("X",'FontSize',15);
ylabel("f(x)",'FontSize',15);
title('Cubic Spline Interpolation Graph','FontSize',25);
legend('Data Points','Cubic Spline','FontSize',15);
grid on;