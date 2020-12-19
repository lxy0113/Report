function [I3]= Rotate(I,N)

% I=ProjImg(:,:,1);
% figure
% imshow(I,[]);

%% 增加采样点
k=10;
scale_size=[k*N,k*N];
I0=sf(I,scale_size);
%% 旋转
[X,Y]=meshgrid(-k*N/2+0.5:k*N/2-0.5,-k*N/2+0.5:k*N/2-0.5);%图像坐标
theta_z=1;
 Rx=X.*cosd(theta_z)-Y.*sind(theta_z);
 Ry=X.*sind(theta_z)+Y.*cosd(theta_z);
I1=interp2(X,Y,I0,Rx,Ry,'linear',0); 
 Rx=X.*cosd(-theta_z)-Y.*sind(-theta_z);
 Ry=X.*sind(-theta_z)+Y.*cosd(-theta_z);
I2=interp2(X,Y,I1,Rx,Ry,'linear',0);
scale_size1=[N,N];
I3=sf(I,scale_size1);
% error1=I3-I;
% figure
% imshow(error1,[]);
% 
% oo=sum(I);
% aa=sum(I3);
% [m1,index1]=max(oo);
% [m2,index2]=max(aa);
