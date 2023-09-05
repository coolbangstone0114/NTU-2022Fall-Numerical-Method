%=====================================================
% Gauss - Legendre quadrature
%=====================================================
% a : low boundary of integration
% b : high boundary of integration (b>a)
% n : number of points for evaluating f
%=====================================================

function [x,w] = gauss_leg(a,b,n);

if (a < b)

    % Build Pn (Legendre Poly of order n) by recurrence :
    p(1,1)  =1;
    p(2,1:2)=[1 0];
    for k=2:n
        p(k+1,1:k+1)=((2*k-1)*[p(k,1:k) 0]-(k-1)*[0 0 p(k-1,1:k-1)])/k;
    end

    Pn       = p(n+1,:);
    Pn_deriv = polyder(Pn);

    x        = roots(Pn);
    w        = 2./((1-x.^2).*(polyval(Pn_deriv,x)).^2);

    % Go back to interval [a,b] :
    x        = (b+a)/2 + (b-a).*x/2;
    w        = (b-a)/2 * w;

else
    disp('a >= b !!');
end;
