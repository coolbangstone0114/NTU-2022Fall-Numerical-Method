clear
kh = 0:0.01:pi;
khexact = kh.^2;
kh_cen = 2 - 2*cos(kh);
kh_for = -12*(cos(kh)-1)./(cos(kh)+5);
%plot
plot(kh,khexact);
hold on 
plot(kh,kh_cen);
plot(kh,kh_for);
xlabel("kh",'FontSize',20);
ylabel("k'h",'FontSize',20);
title("Modified wavenumbers",'FontSize',15);
legend('exact wavenumber', 'Central difference','Pade scheme','Location','NorthWest');