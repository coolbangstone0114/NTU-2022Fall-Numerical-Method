clear
x = 4;
% Function
f = @(x) sin(x)/x^3;
% Analytic first derivative
df = @(x) cos(x)/x^3-3*sin(x)/x^4;
% Forward difference
forward = @(x,h) (f(x+h) - f(x))/h;
% Central difference
central = @(x,h) ( f(x+h) - f(x-h))/2/h;
% Fourth order difference
fourth = @(x,h) ( f(x-2*h) - 8*f(x-h) + 8*f(x+h) - f(x+2*h) )/12/h;

%Evaluate error in finite differences
h = [0.005 0.01 0.05 0.1 0.5 1];
for_err = [];
cen_err = [];
fth_err = [];

for i = 1:length(h)
    for_err(i) = abs(forward(x,h(i)) - df(x));
end

for i = 1:length(h)
    cen_err(i) = abs(central(x,h(i)) - df(x));
end

for i = 1:length(h)
    fth_err(i) = abs(fourth(x,h(i)) - df(x));
end

%plot
figure(1),clf
loglog(h,for_err,'o-')
hold on
loglog(h,cen_err,'ko-')
loglog(h,fth_err,'ro-')
xlabel('h grid spacing','FontSize',12)
ylabel('Error','FontSize',12)
legend('Forward difference','Second-order central difference','Fourth-order central difference','Location','NorthWest')
