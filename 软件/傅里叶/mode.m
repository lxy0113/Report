%% ģ��
RN=128;
N=RN;
theta=0:179;
nviews=180;
nbins=N;
I=zeros(N,N,N);
center=[-N/4,-N/4,-N/4];
center1=[-N/4+20,-N/4+50,-N/4];
center2=[N/2,N/2];
h1=-N/6;h2=N/2;
r=4;r1=10;r2=18;
[A,B,C]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);
I((A-center(1)).^2+(B-center(2)).^2+(C-center(3)).^2<=r^2)=1;
% I((A-center1(1)).^2+(B-center1(2)).^2+(C-center1(3)).^2<=r1^2)=1;
I(64:70,56:60,84:94)=0.5;
ProjImg=Radon3D(I,theta);
%% ��̽�����������Ͱڶ�
%���������Ͱڶ��Ĳ���
m_x=round(rand(1,nviews)*2);%0~2�����������
m_y=round(rand(1,nviews)*2);%0~2�����������
theta_z=0.1*round(rand(1,nviews)*10);%0~1�����0.1
theta_z(1)=0.3;
theta_z(91)=0.8;
px=zeros(nbins+20,N+20,nviews);%�������
px(11:nbins+10,11:N+10,:)=ProjImg;
[X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%ͼ������
p_xy=zeros(nbins,N,nviews);%�����Ͷ���֮�����Ͷͼ
p_z=zeros(nbins,N,nviews);%�ڶ�֮�����Ͷͼ
k=3;
tic;
for i=1:180
    p_xy(:,:,i)=px(11+m_x(i):nbins+m_x(i)+10,11+m_y(i):N+10+m_y(i),i);
    p_z(:,:,i)=Rotate1(p_xy(:,:,i),k,theta_z(i));
end
toc;