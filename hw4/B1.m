clear
%初始化
f = @(x) sin(3*x) + 3*cos(6*x);
f_d = @(x) 3*cos(3*x)-18*sin(6*x);
N=32; %N的值
h=2*pi/N;
x = 0:0.01:2*pi;

%Exact differential
plot(x, f_d(x));
hold on;

%central difference
n=1:N-1;
f_central = (f(h*(n+1))-f(h*(n-1)))/(2*h); 
plot((n*h), f_central, 'ks');
hold on;

%FFT
k=[(0:N/2-1)'; (-N/2: -1)']';
k(1)=0;
x=0:h:2*pi-h;
f_hat = fft(f(x));
f_hat_d = 1i*k.*f_hat;
f_FFT = ifft(f_hat_d);
plot(x, f_FFT, '^');

%plot
xlabel('x');
ylabel('f(x)')
title('N=32')
legend('Exact', 'Central diff', 'FFT', 'location', 'northeast')