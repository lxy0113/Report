%% ��i���Ƕ��µ���Ͷ
function [p1]=iproj_3D(image,dis,angle,nviews,nbins,i)

%% ���ò���
% m_x=floor(11*rand(1,nviews));%������0-10�����������
% m_y=floor(11*rand(1,nviews));%������0-10�����������
% theta_z=floor(10*rand(1,nviews))/10;%�ڽǣ�0-1���������,���0.1
m_x=zeros(nviews);%����0
m_y=zeros(nviews);%����0
theta_z=zeros(nviews);%�ڽ�0
% m_y(90)=5;
% theta_z(1)=0;
% theta_z(2)=0.1;
% theta_z(3)=0.01;
% theta_z(4)=0.001;

%% ��ɢ����
[M,N,K]=size(image);
N_step=N/nbins;
M_step=M/nbins;
K_step=K/nbins;
[X,Y,Z]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5,-K/2+0.5:K/2-0.5);
[Rx,Ry,RZ]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2,-K/2+K_step/2:K_step:K/2-K_step/2);
[X1,Y1]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
% proj=zeros(nviews,nbins,nbins);
% proj1=zeros(nviews,nbins,nbins);
%% ��i���Ƕ���Ͷ
p=zeros(nbins+20,nbins+20);
proj=dis*proj3D(image,X,Y,Z,Rx,Ry,RZ,angle);
    for j=1:nbins
        for k=1:nbins
            ima(j,k)=proj(1,j,k);
        end
    end
% imshow(ima,[]);
% pause(0.5)
p(11:nbins+10,11:nbins+10)=proj;
%�����;����ı�
pp=p((11-m_x(i)):(nbins+10-m_x(i)),(11-m_y(i)):(nbins+10-m_y(i)));
% title([' m_x=',num2str(m_x(i)),'m_y=',num2str(m_y(i))]);
% pause(0.5);
R1=X1.*cosd(theta_z(i))+Y1.*sind(theta_z(i));
R2=-X1.*sind(theta_z(i))+Y1.*cosd(theta_z(i));
p1=interp2(X1,Y1,pp,R1,R2,'linear',0);
% if(i==1)
%     theta_0=zeros(nbins,nbins);
%     theta_0=p1;
%     save theta_0;
% end
end