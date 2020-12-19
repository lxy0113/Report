function [Iweight,Param_x] = Fit_by_LLS(weight,theta)
%% Fit_by_LLS ͨ��������С���˷�������Ժ���
% �ú���ʵ�����������Ժ�������С����(Linear Least Square,LLS)���
% ���������Ƶ������¡��������׷ֱ�ȫ����΢CT��������ת̨У�������о�v1015��ʽ(3.27)-(3.34)
% ����ϵ����Ժ���1��ʾʽ��x(A_c,A_s,B,theta)=A_c*sin(theta)+A_s*cos(theta)+B
% ����ϵ����Ժ���2���ʽ��y(c,theta)=Y_c

% weight_a ������������꣨x(theta),y(theta))
% theta ��Ӧ�ĽǶ��Ա���
% 
% Param_x ����x�Ĳ���A_c,A_s,B
% Param_y ����y�Ĳ���Y_c 



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