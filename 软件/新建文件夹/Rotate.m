function [I3]= Rotate(I,k)
[N,M]=size(I);
%% 增加采样点
I0=imresize(I,k);
%% 旋转
[X,Y]=meshgrid(-k*N/2+0.5:k*N/2-0.5,-k*N/2+0.5:k*N/2-0.5);%图像坐标
theta_z=0.3;
% Rx=X.*cosd(theta_z)-Y.*sind(theta_z);
% Ry=X.*sind(theta_z)+Y.*cosd(theta_z);
% I1=interp2(X,Y,I0,Rx,Ry,'linear',0); 
Rx=X.*cosd(-theta_z)-Y.*sind(-theta_z);
Ry=X.*sind(-theta_z)+Y.*cosd(-theta_z);
I2=interp2(X,Y,I0,Rx,Ry,'linear',0);
I3=imresize(I2,1/k);
end
