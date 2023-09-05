clear
clc
%初始化
N = 7;
u = @(x) 4*(x.^2-x.^4).*exp(-x/2);
u_d = @(x) 2*x.*(x.^3-8*x.^2-x+4).*exp(-x/2);
u_dd = @(x) -(x.^4-16*x.^3+47*x.^2+8*x-8).*exp(-x/2);
j = (0:N)';
X = cos(j*pi/N);
U = u(X);
x = -1:0.01:1;

%Calculate diff matrix D1, D2
D1 = zeros(N+1, N+1);
for j = 1:N+1
  for k = 1:N+1
    if j==k
      switch j
        case 1
          D1(j,k) = (2*N^2+1)/6;
        case N+1
          D1(j,k) = -(2*N^2+1)/6;
        otherwise
          D1(j,k) = -X(j)/(2*(1-X(j)^2));
      end
    else
      if or (j==1, j==N+1)
          cj = 2;
      else 
          cj = 1;
      end
      if or (k==1, k==N+1) 
          ck = 2;
      else 
          ck = 1;
      end
      D1(j,k) = cj*(-1)^(j+k)/(ck*(X(j)-X(k)));
    end  
  end
end

D2 = D1*D1;
%Calculate derivatives of u(x)
U_d = D1*U;
U_dd = D2*U;
%plot
figure(1)
plot(x, u_d(x));
hold on;
plot(X, U_d, 'o');
xlabel('X');
ylabel("u'");
title("u'");
legend('Exact', "u'")
figure(2)
plot(x, u_dd(x));
hold on;
plot(X, U_dd, 'o');
xlabel('X');
ylabel("u''");
title("u''");
legend('Exact', 'U dd')

%print
X
U
D1
D2
U_d
U_dd









