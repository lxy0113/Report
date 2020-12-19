function [I2]= Rotate1(I,k,theta_z)
[N,M]=size(I);
[X,Y]=meshgrid(-k*N/2+0.5:k*N/2-0.5,-k*N/2+0.5:k*N/2-0.5);%ͼ������
%% ���Ӳ�����
I0=imresize(I,k);
%% ��ת
Rx=X.*cosd(theta_z)-Y.*sind(theta_z);
Ry=X.*sind(theta_z)+Y.*cosd(theta_z);
I1=interp2(X,Y,I0,Rx,Ry,'linear',0); 
I2=imresize(I1,1/k);
end
