function [proj1]=pro1_3D(image,dis,angle_step,z_angle,nviews,nbins)
%% 网格离散化
[M,N,K]=size(image);
N_step=N/nbins;
M_step=M/nbins;
K_step=K/nbins;
[X,Y,Z]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5,-K/2+0.5:K/2-0.5);
[Rx,Ry,RZ]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2,-K/2+K_step/2:K_step:K/2-K_step/2);
angle=0:angle_step:z_angle-angle_step;
proj=zeros(nbins,nbins,nviews);
proj1=zeros(nviews,nbins,nbins);
m_x=floor(4*rand(1,nviews));%径跳（0-10）的随机整数
% m_y=floor(11*rand(1,nviews));%端跳（0-10）的随机整数
% theta_z=rand(1,nviews);%摆角（0-1）的随机数
% m_x=zeros(1,nviews);%径跳0
m_y=zeros(1,nviews);%端跳0
% m_y(90)=5;
theta_z=zeros(1,nviews);%摆角0
% theta_z(1)=0;
% theta_z(2)=0.1;
% theta_z(3)=0.01;
% theta_z(4)=0.001;
[X1,Y1]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
p1=zeros(nbins,nbins);
pp=zeros(nbins,nbins);
for i=1:nviews
    proj(:,:,i)=dis*proj3D(image,X,Y,Z,Rx,Ry,RZ,angle(i));
    %%对探测器进行平移和旋转(随机的径跳、端跳和摆动)
    % 定义一个二维矩阵
%        for j=1:nbins
%         for k=1:nbins
%             ima(j,k)=proj(i,j,k);
%         end
%        end
%     imshow(ima,[]);
%     pause(0.5);
    p=zeros(nbins+20,nbins+20);
    for j=11:nbins+10
        for k=11:nbins+10
            p(j,k)=proj(j-10,k-10,i);
        end
    end
    pp=p((11-m_x(i)):(nbins+10-m_x(i)),(11-m_y(i)):(nbins+10-m_y(i)));
    title([' m_x=',num2str(m_x(i)),'m_y=',num2str(m_y(i))]);
    R1=X1.*cosd(theta_z(i))+Y1.*sind(theta_z(i));
    R2=-X1.*sind(theta_z(i))+Y1.*cosd(theta_z(i));
    p1=interp2(X1,Y1,pp,R1,R2,'linear',0);
    proj1(i,:,:)=p1;
%     if(i==1)
%         m1=ima;
%         save m1;
%     end
%     if(i==20)
%         m20=ima;
%        
%         save m20;
%     end
%     if(i==90)
%         m3=ima;
%         save m3;
%     end
%     if(i==50)
%         m50=ima;
%         save m50;
%     end
%     
    
    
    
    
%     if(i==4)
%         theta_0001=zeros(nbins,nbins);
%         theta_0001=p1;
%         save theta_0001;
%     end
%         if(i==90)
%         proj_590=zeros(nbins,nbins);
%         proj_590=p1;
%         save proj_590;
%     end
%     figure
%     imshow(p,[]);
%     title(['标准正投影']);
%     figure
%     imshow(pp,[]);
%     figure
%     imshow(p1',[]);
%     title(['view=',num2str(i),'° m_x=',num2str(m_x(i)),'m_y=',num2str(m_y(i)),'theta_z=',num2str(theta_z(i))]);
%     pause(0.5);
end
% label=zeros(nviews,3);
% label(:,1)=m_x(1,:);
% label(:,2)=m_y(1,:);
% label(:,3)=theta_z(1,:);
% save label;
end