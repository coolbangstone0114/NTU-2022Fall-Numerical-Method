clear
clc
x = -3:0.01:3;
y = -3:0.01:3;
[x,y] = meshgrid(x,y);
z = x + 1i*y;

%Second order RK method
sigma = 1 + z + (z.^2)/2;
%Display the contours of the peaks function at sigma = 1.
contour(x,y,abs(sigma),[1,1],'ShowText','on');
grid on;
title('Second order RK method');
xlabel('Re(\lambdah)');
ylabel('Im(\lambdah)');

% %Fourth order RK method
% sigma = 1 + z + (z.^2)/2 + (z.^3)/6 + (z.^4)/24;
% %Display the contours of the peaks function at sigma = 1.
% contour(x,y,abs(sigma),[1,1],'ShowText','on');
% grid on;
% title('Fourth order RK method');
% xlabel('Re(\lambdah)');
% ylabel('Im(\lambdah)');
