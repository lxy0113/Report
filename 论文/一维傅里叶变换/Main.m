% clc,clear;
% close all;
%% ��������
k=12;

%% ����ģ��
n=1;%1��ʾѡ���ģ�壬2��ʾ����ģ��
N=128;%N��ģ���С
OriImg=Mode(1,N);
imshow(OriImg(:,:,N/2),[]);
%% ������Ͷ
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
% %% ʵ��һ
% % [pm_x,pm_y,ptheta_z,p_z]=Test1(ProjImg,m_x,m_y,theta_z,x,y,theta,k);
[p_z]=Test1(ProjImg,m_x,m_y,theta_z,k);

%% ʵ���
% Test2(pm_x,pm_y,ptheta_z,ProjImg);

