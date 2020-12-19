function [Iweight,Param_x] = Fit_by_LLS(weight,theta)
%% Fit_by_LLS 通过线性最小二乘法拟合线性函数
% 该函数实现了两个线性函数的最小二乘(Linear Least Square,LLS)拟合
% 具体表达与推导见文章《基于纳米分辨全场显微CT成像技术的转台校正方法研究v1015》式(3.27)-(3.34)
% 被拟合的线性函数1表示式：x(A_c,A_s,B,theta)=A_c*sin(theta)+A_s*cos(theta)+B
% 被拟合的线性函数2表达式：y(c,theta)=Y_c

% weight_a 输入的质心坐标（x(theta),y(theta))
% theta 对应的角度自变量
% 
% Param_x 函数x的参数A_c,A_s,B
% Param_y 函数y的参数Y_c 



Iangle=length(theta);
if size(weight,2)==2
    X_theta=weight(:,1);
    Y_theta=weight(:,2);
end

if size(weight,2)==1
    X_theta=weight(:,1);
    Y_theta=X_theta*0;
end





% X_theta=cosd(theta');


M_theta=[sind(theta') cosd(theta') ones(Iangle,1)];

Param_x=(M_theta'*M_theta)^(-1)*M_theta'*X_theta;
Param_y=mean(Y_theta);

A_c=Param_x(1);
A_s=Param_x(2);
B=Param_x(3);
Y_c=Param_y;

Iweight=weight*0;
Iweight(:,1)=A_c*sind(theta')+A_s*cosd(theta')+B;
Iweight(:,2)=Y_c;


if size(weight,2)==1
    Iweight=Iweight(:,1);
end



end