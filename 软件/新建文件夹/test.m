clc,clear;
close all;
% %%
RN=512;
N=RN;
theta=0:179;
nviews=180;
nbins=N;
I=zeros(N,N,N);
center=[N/4,N/4,N/4];
center1=[-N/4+20,-N/4+50,-N/4];
center2=[N/2,N/2];
h1=-N/6;h2=N/2;
r=4;r1=10;r2=18;
[A,B,C]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);
I((A-center(1)).^2+(B-center(2)).^2+(C-center(3)).^2<=r^2)=1;
% I((A-center1(1)).^2+(B-center1(2)).^2+(C-center1(3)).^2<=r1^2)=1;
I(101:110,90:104,84:94)=0.5;
ProjImg=Radon3D(I,theta);
% save ProjImg
% load ProjImg;
% Isize=512;
% theta=1:180;
% nviews=180;
% nbins=Isize;
% Iangle=length(theta);
% OriImg=zeros(Isize,Isize,Isize);
% tx=1:Isize;
% [TX,TY,TZ]=meshgrid(tx,tx,tx);
% CId=ones(1,3)*Isize/2;
% % OriImg=zeros(size(OriImg),); 
% % 主体球
% MainR=Isize/3;
% zoomM=CId;
% MainId01=(TX-zoomM(1)).^2+(TY-zoomM(2)).^2+(TZ-zoomM(3)).^2<MainR^2;
% MainId=MainId01;
% OriImg(MainId)=4.7*1e-6/32;
% % OriImg(MainId)=4.7/32;
% % 小球1
% Ball01R=MainR/8;
% zoomB01=[-MainR/2 MainR/2 48]+CId;
% B01Id=(TX-zoomB01(1)).^2+(TY-zoomB01(2)).^2+(TZ-zoomB01(3)).^2<Ball01R^2;
% OriImg(B01Id)=51.5*1e-6/32;
% % OriImg(B01Id)=51.5/32;
% % 方块1
% Sq01L=MainR/8;
% zoomSq01=[MainR/2 MainR/2 16]+CId;
% Sq01Id=((abs(TX-zoomSq01(1))<Sq01L)+(abs(TY-zoomSq01(2))<Sq01L)+(abs(TZ-zoomSq01(3))<Sq01L))>2;
% OriImg(Sq01Id)=51.5*1e-6/32;
% % OriImg(Sq01Id)=51.5/32;
% %
% % 圆柱1
% Cder01R=MainR/8;
% Cder01H=MainR/8;
% zoomCder01=[MainR/2 -MainR/2 -16]+CId;
% Cder01Id=(TX-zoomCder01(1)).^2+(TY-zoomCder01(2)).^2<Cder01R^2;
% Cder01Id=((abs(TZ-zoomCder01(3))<Cder01H)+Cder01Id)>1;
% OriImg(Cder01Id)=51.5*1e-6/32;
% % OriImg(Cder01Id)=51.5/32;
% % 圆锥1
% Cone01R=MainR/8;
% Cone01H=MainR/8;
% zoomCone01=[-MainR/2 -MainR/2 -48]+CId;
% Cone01Id=(TX-zoomCone01(1)).^2+(TY-zoomCone01(2)).^2-(TZ-zoomCone01(3)-Cone01H).^2/4<0;
% Cone01Id=(abs(TZ-zoomCone01(3))<Cone01H)+Cone01Id>1;
% OriImg(Cone01Id)=51.5*1e-6/32;
% % OriImg(Cone01Id)=51.5/32;
% 
% ProjImg=Radon3D(OriImg,theta);
%% 加探测器的跳动和摆动
%设置跳动和摆动的参数
m_x=round(rand(1,nviews)*4)-2;%0~2的随机正整数
% m_y=round(rand(1,nviews)*2);%0~2的随机正整数
% theta_z=0.1*round(rand(1,nviews)*10);%0~1，间隔0.1
% m_x=zeros(1,nviews);
m_y=zeros(1,nviews);
theta_z=zeros(1,nviews);
% m_x(1)=1;
% theta_z(1)=0.3;
px=zeros(nbins+20,N+20,nviews);%扩充矩阵
px(11:nbins+10,11:N+10,:)=ProjImg;
[X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%图像坐标
p_xy=zeros(nbins,N,nviews);%径跳和端跳之后的正投图
p_z=zeros(nbins,N,nviews);%摆动之后的正投图
k=3;
tic;
for i=1:180
    p_xy(:,:,i)=px(11+m_x(i):nbins+m_x(i)+10,11+m_y(i):N+10+m_y(i),i);
    %每个角度下，旋转
%     Rx=X.*cosd(theta_z(i))-Y.*sind(theta_z(i));
%     Ry=X.*sind(theta_z(i))+Y.*cosd(theta_z(i));
%     p_z(:,:,i)=interp2(X,Y,p_xy(:,:,i),Rx,Ry,'linear',0); 
%     if(i>=104&&i<=110)
%         k=20;
%     else
%         k=12;
%     end
%     p_z(:,:,i)=Rotate1(p_xy(:,:,i),k,theta_z(i));
end
toc;
%pproj是经过跳动和摆动之后的，重组成proj的矩阵格式
% pproj=zeros(nviews,nbins,N);
% for i=1:N
%     for j=1:nbins
%         for k=1:nviews
%             pproj(k,i,j)=p_z(j,i,k);
%         end
%     end
% end
% 
% ReBdImg=iRadon3D(p_z,theta,RN,2);
% 
% imshow3D(ProjImg,180,1);
% imshow3D(ReBdImg,128,2);

