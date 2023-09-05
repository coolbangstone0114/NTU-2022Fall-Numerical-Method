clear
% define Function
f = @(x) sin(x);

% 4 intervals
x_4 = linspace(0,pi,5);
delta_x4 = pi/4;
I_4 = 0;
for i=1:4
    I_4 = I_4 + delta_x4*(f(x_4(i)) + f(x_4(i+1)))/2 + delta_x4^3*(f(x_4(i)) + f(x_4(i+1)))/24;
end

% 8 intervals
x_8 = linspace(0,pi,9);
delta_x8 = pi/8;
I_8 = 0;
for i=1:8
    I_8 = I_8 + delta_x8*(f(x_8(i)) + f(x_8(i+1)))/2 + delta_x8^3*(f(x_8(i)) + f(x_8(i+1)))/24;
end

% 16 intervals
x_16 = linspace(0,pi,17);
delta_x16 = pi/16;
I_16 = 0;
for i=1:16
    I_16 = I_16 + delta_x16*(f(x_16(i)) + f(x_16(i+1)))/2 + delta_x16^3*(f(x_16(i)) + f(x_16(i+1)))/24;
end

% 32 intervals
x_32 = linspace(0,pi,33);
delta_x32 = pi/32;
I_32 = 0;
for i=1:32
    I_32 = I_32 + delta_x32*(f(x_32(i)) + f(x_32(i+1)))/2 + delta_x32^3*(f(x_32(i)) + f(x_32(i+1)))/24;
end

%print the result
sprintf("Intergral of 4 intervals = %0.10f", I_4)
sprintf("Intergral of 8 intervals = %0.10f", I_8)
sprintf("Intergral of 16 intervals = %0.10f", I_16)
sprintf("Intergral of 32 intervals = %0.10f", I_32)

%error analysis
I_exact = 2;
error_4 = abs(I_exact - I_4);
error_8 = abs(I_exact - I_8);
error_16 = abs(I_exact - I_16);
error_32 = abs(I_exact - I_32);
log_x = [pi/4 pi/8 pi/16 pi/32];
log_y = [error_4 error_8 error_16 error_32];
plot(log2(log_x), log2(log_y),'o-');
sprintf("slope = %0.10f", (log2(log_y(1)) - log2(log_y(2)))/(log2(log_x(1)) - log2(log_x(2))))