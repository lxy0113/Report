% function [pm_x,pm_y,ptheta_z,p_z]=Test1(ProjImg,m_x,m_y,theta_z,x,y,theta,k)
function [p_z]=Test1(ProjImg,m_x,m_y,theta_z,k)
[N,~,nViews]=size(ProjImg);
%% 正投图像处理
% %% 只有m_x
% px=zeros(N+2*x,N+2*y,nViews);%扩充矩阵
% px(x+1:N+x,y+1:N+y,:)=ProjImg;
% pm_x=zeros(N,N,nViews);%端跳之后的正投图
% for i=1:180
%     pm_x(:,:,i)=px(x+1+m_x(i):N+m_x(i)+x,y+1:N+y,i);
% end

%% 只有m_y
% pm_y=zeros(N,N,nViews);%端跳之后的正投图
% for i=1:180
%     pm_y(:,:,i)=px(x+1:N+x,y+1+m_y(i):N+y+m_y(i),i);
% end

% %% 只有theta_z
% ptheta_z=zeros(N,N,nViews);%端跳之后的正投图
% for i=1:nViews
%     ptheta_z(:,:,i)=Rotate1(ProjImg(:,:,i),k,theta_z(i));
% end
% 
% %% 三个同时同在
p_xy=zeros(N,N,nViews);%径跳和端跳之后的正投图
p_z=zeros(N,N,nViews);%摆动之后的正投图
[X,Y]=meshgrid(k*(-N/2)+0.5:k*(N/2)-0.5,k*(-N/2)+0.5:k*(N/2)-0.5);
for i=1:nViews
    %平移
    [IX,IY]=meshgrid(k*(-N/2-m_x(i))+0.5:k*(N/2-m_x(i))-0.5,k*(-N/2-m_y(i))+0.5:k*(N/2-m_y(i))-0.5);
    p_xy(:,:,i)=interp2(X,Y,ProjImg(:,:,i),IX,IY,'linear',0);
    %每个角度下，旋转
    p_z(:,:,i)=Rotate1(p_xy(:,:,i),k,theta_z(i));
end
end