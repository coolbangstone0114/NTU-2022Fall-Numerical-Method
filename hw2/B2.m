clear
kh = 0:0.01:pi;
khexact = kh;
kh_cen = sin(kh);
kh_for = (-sin(2*kh) + 8*sin(kh))/6;
kh_pade = 3*sin(kh)./(cos(kh)+2);
%plot
plot(kh,khexact);
hold on 
plot(kh,kh_cen, '--');
plot(kh,kh_for, 'k:');
plot(kh,kh_pade, '-.');
xlabel("kh",'FontSize',20);
ylabel("k'h",'FontSize',20);
title("Modified wavenumbers",'FontSize',15);
legend('exact wavenumber', '2nd order central difference','4th order central difference','4th order Pade scheme','Location','NorthWest');