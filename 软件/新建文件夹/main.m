% clc;
% clear;
%% 参数设置
N=128;
nbins=N;
nviews=180;
angle=180;
angle_step=angle/nviews;
theta=0:angle_step:angle-angle_step;
%% 建模
I=zeros(N,N,N);
center=[-N/4,-N/4,-N/4];
r=8;
[A,B,C]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);
I((A-center(1)).^2+(B-center(2)).^2+(C-center(3)).^2<=r^2)=1;
%% 正投过程
proj=zeros(nviews,nbins,N);
p=zeros(nbins,N,nviews);%重新组合之后，每个角度的正投影
tic;
for i=1:N
    %把每层返回的正投图组成一个矩阵，大小为nviews*nbins*N
    proj(:,:,i)=para1_2D(I(:,:,i),N,nbins,nviews,theta);
    % 重新组合正投图像，可以生成每个角度的正投图，大小nbins*N*nviews
    for j=1:nbins
        for k=1:nviews
            p(i,j,k)=proj(k,j,i);
        end
    end
end
% toc;
% 
% %% 加探测器的跳动和摆动
% %设置跳动和摆动的参数
m_x=round(rand(1,nviews)*2);%0~2的随机正整数
m_y=round(rand(1,nviews)*2);%0~2的随机正整数
theta_z=0.1*round(rand(1,nviews)*10);%0~1，间隔0.1
% % m_x=zeros(1,nviews);%0
% m_y=zeros(1,nviews);%0
theta_z(1)=0.3;
m_x(1)=1;
px=zeros(nbins+20,N+20,nviews);%扩充矩阵
px(11:nbins+10,11:N+10,:)=p;
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%图像坐标
% p_xy=zeros(nbins,N,nviews);%径跳和端跳之后的正投图
% p_z=zeros(nbins,N,nviews);%摆动之后的正投图
k=1;
for i=1:18
    p_xy(:,:,i)=px(11+m_x(i):nbins+m_x(i)+10,11+m_y(i):N+10+m_y(i),i);
    %每个角度下，旋转
    p_z(:,:,i)=Rotate1(p_xy(:,:,i),k,theta_z(i));
%     Rx=X.*cosd(theta_z(i))-Y.*sind(theta_z(i));
%     Ry=X.*sind(theta_z(i))+Y.*cosd(theta_z(i));
%     p_z(:,:,i)=interp2(X,Y,p_xy(:,:,i),Rx,Ry,'linear',0);
end
%pproj是经过跳动和摆动之后的，重组成proj的矩阵格式
% pproj=zeros(nviews,nbins,N);
% for i=1:N
%     for j=1:nbins
%         for k=1:nviews
%             pproj(k,i,j)=p_z(j,i,k);
%         end
%     end
% end
% save p_z;
% save p;
% erro=p-p_z;
% %% 重建
% I0=zeros(N,N,N);
% k_final=10;
% dis=1;
% [RX,RY]=meshgrid(-N/2+0.5:dis:N/2-0.5,-N/2+0.5:N/2-0.5);%采样点的坐标
% for iter=1:k_final
%     tic;
%     %分层重建
%     for i=1:N
%         %每个角度下得到的重建向量
%         for j=1:nviews
%             error=(pproj(j,:,i)-dis*projection(I0(:,:,i),X,Y,RX,RY,theta(j)))/N;
%             XI=X.*cosd(theta(j))-Y.*sind(theta(j));
%             I0(:,:,i)=I0(:,:,i)+interp1(X(1,:),error,XI,'linear',0);%把误差平均的加到图片上
%         end       
%     end
%     I0(I0<0)=0;
%     I0(I0>1)=1; 
%     toc;
% end
% err=I-I0;    
% 
% %% 保存文件
% save p;
% label=zeros(nviews,3);
% label(:,1)=m_x;
% label(:,2)=m_y;
% label(:,3)=theta_z;
% save label;
