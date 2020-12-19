% clc,clear;
% close all;
%% 参数设置
k=12;

%% 导入模体
n=1;%1表示选择简单模体，2表示复杂模体
N=128;%N是模体大小
OriImg=Mode(1,N);
imshow(OriImg(:,:,N/2),[]);
%% 生成正投
nViews=4;
theta=0:nViews-1;
ProjImg=Radon3D(OriImg,theta);
for i=1:nViews
    imshow(ProjImg(:,:,i),[]);
    pause(0.2);
end
% figure
% for i=1:nViews
%     imshow(ptheta_z(:,:,i),[]);
%     pause(0.2);
% end
[m_x,m_y,theta_z,x,y,z]=Parameter(nViews,N);
% %% 实验一
% % [pm_x,pm_y,ptheta_z,p_z]=Test1(ProjImg,m_x,m_y,theta_z,x,y,theta,k);
[p_z]=Test1(ProjImg,m_x,m_y,theta_z,k);

%% 实验二
% Test2(pm_x,pm_y,ptheta_z,ProjImg);

