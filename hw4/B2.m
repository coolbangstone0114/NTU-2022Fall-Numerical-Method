clear
%初始化
f = @(x) 6*x-x.^2;
f_d = @(x) 6-2*x;
N=16;
h=2*pi/N;
x = 0:0.01:2*pi;

%Exact differential
plot (x, f_d(x));
hold on;

%central difference
n=1:N-1;
f_central = (f(h*(n+1)) - f(h*(n-1)))/(2*h);

%FFT
k=[(0:N/2-1)'; (-N/2:(-1))']';
k(1)=0;
x=0:h:2*pi-h;
f_hat = fft(f(x));
f_hat_d = 1i*k.*f_hat;
f_FFT = ifft(f_hat_d);

%plot
plot((n*h), f_central, '^');
plot (x,f_FFT, 'ks');
xlabel('x');
ylabel('f(x)')
title ('N = 16')
legend ('exact', 'central diff', 'FFT', 'location', 'northeast')