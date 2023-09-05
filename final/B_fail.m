clc
clear
% 初始化邊界
% Set tolerance and maximum number of iterations
tol = 10^(-4);
maxIter = 134;

% Set up grid and initial guesses for f and g 其中 g = f'
% delta : 0.4, 0.3, 0.2, 0.1
delta_eta = 0.4;
eta = 0:delta_eta:6;
pt_num = length(eta);
f = (eta.^2)/12;
g = (eta/6);

% Calculate derivative at interior points using central differences
df = zeros(size(eta));
dg = zeros(size(eta));
d2f = zeros(size(eta));
d2g = zeros(size(eta));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start iterating %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for m = 1:maxIter
    fprintf('Iteration:%d\n', m)
    % Calculate 1st and 2nd derivative of f and g using 3-point central differences
    for i = 2:length(eta)-1
        df(i) = (f(i+1) - f(i-1)) / (2*delta_eta);
        dg(i) = (g(i+1) - g(i-1)) / (2*delta_eta);
        d2f(i) = (f(i+1) - 2*f(i) + f(i-1)) / (delta_eta)^2;
        d2g(i) = (g(i+1) - 2*g(i) + g(i-1)) / (delta_eta)^2;
    end

    % Calculate 1st and 2nd derivative of g and g at end points using 3-point one-sided differences
    df(1) = (4*f(2) - 3*f(1) - f(3)) / (2*delta_eta);%Right-sided OK
    dg(1) = (4*g(2) - 3*g(1) - g(3)) / (2*delta_eta);%Right-sided

    d2f(1) = (f(3) - 2*f(2) + f(1) ) / (delta_eta)^2;%Right-sided OK
    d2g(1) = (g(3) - 2*g(2) + g(1) ) / (delta_eta)^2;%Right-sided

    df(end) = (-4*f(end-1) + 3*f(end) + f(end-2)) / (2*delta_eta);%Left-sided OK
    dg(end) = (-4*g(end-1) + 3*g(end) + g(end-2)) / (2*delta_eta);%Left-sided

    d2f(end) = (f(end-2) + f(end) - 2*f(end-1)) / (delta_eta)^2;%Left-sided OK
    d2g(end) = (g(end-2) + g(end) - 2*g(end-1)) / (delta_eta)^2;%Left-sided

    % Initialize the iter matrix (refresh after each iteration)
    iter_mat = zeros(2*pt_num,2*pt_num);

    % 左上初始化
    for i=2:pt_num
        if ( i==2 ) % Right-sided
            iter_mat(i,i) = -3/(2*delta_eta);
            iter_mat(i,i+1) = 4/(2*delta_eta);
            iter_mat(i,i+2) = -1/(2*delta_eta);
            continue;
        end
        if ( i==pt_num ) % Left-sided
            iter_mat(i,i) = 3/(2*delta_eta);
            iter_mat(i,i-1) = -4/(2*delta_eta);
            iter_mat(i,i-2) = 1/(2*delta_eta);
            continue;
        end
        iter_mat(i,i+1) = 1/(2*delta_eta);
        iter_mat(i,i-1) = -1/(2*delta_eta);
    end

    % 右上初始化 OK
    for i=1:pt_num
        if ( i==1 || i==pt_num )
            continue;
        end
        iter_mat(i,i+pt_num) = -1;
    end

    % 左下初始化 OK
    for i=2:pt_num-1
        iter_mat(i+pt_num,i) = dg(i);
    end

    % 右下初始化 OK
    % f*D1
    for i=pt_num+2:2*pt_num-1
        if ( i==pt_num+2 ) % Right-sided
            iter_mat(i,i) = -3*f(i-pt_num)/(2*delta_eta);
            iter_mat(i,i+1) = 4*f(i-pt_num)/(2*delta_eta);
            iter_mat(i,i+2) = -1*f(i-pt_num)/(2*delta_eta);
            continue;
        end
        if ( i==2*pt_num-1 ) % Left-sided
            iter_mat(i,i) = 3*f(i-pt_num)/(2*delta_eta);
            iter_mat(i,i-1) = -4*f(i-pt_num)/(2*delta_eta);
            iter_mat(i,i-2) = 1*f(i-pt_num)/(2*delta_eta);
            continue;
        end
        iter_mat(i,i+1) = f(i-pt_num)/(2*delta_eta);
        iter_mat(i,i-1) = -f(i-pt_num)/(2*delta_eta);
    end
    % D2
    for i=pt_num+2:2*pt_num-1
        if ( i==pt_num+2 ) % Right-sided
            iter_mat(i,i) = 1/(delta_eta)^2 + iter_mat(i,i);
            iter_mat(i,i+1) = -2/(delta_eta)^2 + iter_mat(i,i+1);
            iter_mat(i,i+2) = 1/(delta_eta)^2 + iter_mat(i,i+2);
            continue;
        end
        if ( i==2*pt_num-1 ) % Left-sided
            iter_mat(i,i) = 1/(delta_eta)^2 + iter_mat(i,i);
            iter_mat(i,i-1) = -2/(delta_eta)^2 + iter_mat(i,i-1);
            iter_mat(i,i-2) = 1/(delta_eta)^2 + iter_mat(i,i-2);
            continue;
        end
        iter_mat(i,i-1) = 1/(delta_eta)^2 + iter_mat(i,i-1);
        iter_mat(i,i) = -2/(delta_eta)^2 + iter_mat(i,i);
        iter_mat(i,i+1) = 1/(delta_eta)^2 + iter_mat(i,i+1);
    end

    % 邊界初始化(考慮B.C.) OK
    [iter_mat(1,1),iter_mat(pt_num+1,pt_num+1),iter_mat(2*pt_num,2*pt_num)] = deal(1);

    % Initialize the result matrix
    result_mat = zeros(2*pt_num,1);
    for i=1:pt_num
        result_mat(i,1) = (g(i) - df(i));
        result_mat(i+pt_num,1) = (-f(i)*dg(i)-d2g(i));
    end

    [result_mat(1,1),result_mat(pt_num+1,1),result_mat(2*pt_num,1)] = deal(0); % 因為假設的邊界條件預設為 0 故此矩陣對應的元素也為 0

    % 求得修正項的矩陣
    modf_mat = rot90(iter_mat\result_mat);
    %[modf_mat(1,1),modf_mat(1,pt_num+1),modf_mat(1,2*pt_num)] = deal(0); % 將假設的邊界條件預設為 0

    % 檢查是否符合需求，有則跳出並繪圖，否則繼續迭代
    if( all(abs(modf_mat(1,1:pt_num))<tol) )
        break;
    end

    % 將原先的 f、g 加上修正矩陣，得到新的 f、g
    f = f + modf_mat(1,1:pt_num);
    g = g + modf_mat(1,pt_num+1:2*pt_num);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End of iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot
hold on
plot(eta,f,'r-');
plot(eta,g,'b-');
plot(eta,d2f,'g-');
xlabel('η');
grid on
title('∆η = 0.4 (16 points)')
legend('f', 'fp','fpp','Location', 'NorthEast','FontSize', 15);
