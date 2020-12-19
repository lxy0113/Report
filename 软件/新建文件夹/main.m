% clc;
% clear;
%% ��������
N=128;
nbins=N;
nviews=180;
angle=180;
angle_step=angle/nviews;
theta=0:angle_step:angle-angle_step;
%% ��ģ
I=zeros(N,N,N);
center=[-N/4,-N/4,-N/4];
r=8;
[A,B,C]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);
I((A-center(1)).^2+(B-center(2)).^2+(C-center(3)).^2<=r^2)=1;
%% ��Ͷ����
proj=zeros(nviews,nbins,N);
p=zeros(nbins,N,nviews);%�������֮��ÿ���Ƕȵ���ͶӰ
tic;
for i=1:N
    %��ÿ�㷵�ص���Ͷͼ���һ�����󣬴�СΪnviews*nbins*N
    proj(:,:,i)=para1_2D(I(:,:,i),N,nbins,nviews,theta);
    % ���������Ͷͼ�񣬿�������ÿ���Ƕȵ���Ͷͼ����Сnbins*N*nviews
    for j=1:nbins
        for k=1:nviews
            p(i,j,k)=proj(k,j,i);
        end
    end
end
% toc;
% 
% %% ��̽�����������Ͱڶ�
% %���������Ͱڶ��Ĳ���
m_x=round(rand(1,nviews)*2);%0~2�����������
m_y=round(rand(1,nviews)*2);%0~2�����������
theta_z=0.1*round(rand(1,nviews)*10);%0~1�����0.1
% % m_x=zeros(1,nviews);%0
% m_y=zeros(1,nviews);%0
theta_z(1)=0.3;
m_x(1)=1;
px=zeros(nbins+20,N+20,nviews);%�������
px(11:nbins+10,11:N+10,:)=p;
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%ͼ������
% p_xy=zeros(nbins,N,nviews);%�����Ͷ���֮�����Ͷͼ
% p_z=zeros(nbins,N,nviews);%�ڶ�֮�����Ͷͼ
k=1;
for i=1:18
    p_xy(:,:,i)=px(11+m_x(i):nbins+m_x(i)+10,11+m_y(i):N+10+m_y(i),i);
    %ÿ���Ƕ��£���ת
    p_z(:,:,i)=Rotate1(p_xy(:,:,i),k,theta_z(i));
%     Rx=X.*cosd(theta_z(i))-Y.*sind(theta_z(i));
%     Ry=X.*sind(theta_z(i))+Y.*cosd(theta_z(i));
%     p_z(:,:,i)=interp2(X,Y,p_xy(:,:,i),Rx,Ry,'linear',0);
end
%pproj�Ǿ��������Ͱڶ�֮��ģ������proj�ľ����ʽ
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
% %% �ؽ�
% I0=zeros(N,N,N);
% k_final=10;
% dis=1;
% [RX,RY]=meshgrid(-N/2+0.5:dis:N/2-0.5,-N/2+0.5:N/2-0.5);%�����������
% for iter=1:k_final
%     tic;
%     %�ֲ��ؽ�
%     for i=1:N
%         %ÿ���Ƕ��µõ����ؽ�����
%         for j=1:nviews
%             error=(pproj(j,:,i)-dis*projection(I0(:,:,i),X,Y,RX,RY,theta(j)))/N;
%             XI=X.*cosd(theta(j))-Y.*sind(theta(j));
%             I0(:,:,i)=I0(:,:,i)+interp1(X(1,:),error,XI,'linear',0);%�����ƽ���ļӵ�ͼƬ��
%         end       
%     end
%     I0(I0<0)=0;
%     I0(I0>1)=1; 
%     toc;
% end
% err=I-I0;    
% 
% %% �����ļ�
% save p;
% label=zeros(nviews,3);
% label(:,1)=m_x;
% label(:,2)=m_y;
% label(:,3)=theta_z;
% save label;
