%% ��̽�����������Ͱڶ�
function [m_x,m_y,theta_z,x,y,z]=Parameter(nviews,N)
if(N==128)
    x=2;y=2;z=1;%���÷�Χ��m_x,m_y����-10~10,���1��theta_z����-1~1�����0.1��
end
if(N==256)
    x=5;y=5;z=1;%���÷�Χ��m_x,m_y����-10~10,���1��theta_z����-1~1�����0.1��
end
if(N==512)
    x=10;y=10;z=1;%���÷�Χ��m_x,m_y����-10~10,���1��theta_z����-1~1�����0.1��
end
m_x=0.00001*(round(rand(1,nviews)*2*x*10000))-x;%0~10�����������
m_y=0.00001*(round(rand(1,nviews)*2*y*10000))-y;%0~10�����������
theta_z=0.1*round(rand(1,nviews)*10*2*z)-z;%0~1�����0.1
%% �������ݷֲ�ͼ
figure(1);
plot(m_x);
hold on;
plot(m_y);
xlabel('ͶӰ�Ƕ�');
ylabel('����');
title('������������������');
legend('����','����');
figure(3);
plot(theta_z);
xlabel('ͶӰ�Ƕ�');
ylabel('�ڽ�');
title('�ڽǲ�������');
end