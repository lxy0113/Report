clc;clear;
%% 构建模型

Isize=512;
theta=1:180;
nviews=180;
nbins=Isize;
Iangle=length(theta);
OriImg=zeros(Isize,Isize,Isize);
tx=1:Isize;
[TX,TY,TZ]=meshgrid(tx,tx,tx);
CId=ones(1,3)*Isize/2;
% OriImg=zeros(size(OriImg),);
% maxIterations=200;
% count = arrayfun( @pctdemo_processMandelbrotElement, ...
%                   TX, TX,TX ,maxIterations ); 
% 主体球
MainR=Isize/3;
zoomM=CId;
MainId01=(TX-zoomM(1)).^2+(TY-zoomM(2)).^2+(TZ-zoomM(3)).^2<MainR^2;
MainId=MainId01;
OriImg(MainId)=4.7*1e-6/32;
% OriImg(MainId)=4.7/32;
% 小球1
Ball01R=MainR/8;
zoomB01=[-MainR/2 MainR/2 48]+CId;
B01Id=(TX-zoomB01(1)).^2+(TY-zoomB01(2)).^2+(TZ-zoomB01(3)).^2<Ball01R^2;
OriImg(B01Id)=51.5*1e-6/32;
% OriImg(B01Id)=51.5/32;
% 方块1
Sq01L=MainR/8;
zoomSq01=[MainR/2 MainR/2 16]+CId;
Sq01Id=((abs(TX-zoomSq01(1))<Sq01L)+(abs(TY-zoomSq01(2))<Sq01L)+(abs(TZ-zoomSq01(3))<Sq01L))>2;
OriImg(Sq01Id)=51.5*1e-6/32;
% OriImg(Sq01Id)=51.5/32;
%
% 圆柱1
Cder01R=MainR/8;
Cder01H=MainR/8;
zoomCder01=[MainR/2 -MainR/2 -16]+CId;
Cder01Id=(TX-zoomCder01(1)).^2+(TY-zoomCder01(2)).^2<Cder01R^2;
Cder01Id=((abs(TZ-zoomCder01(3))<Cder01H)+Cder01Id)>1;
OriImg(Cder01Id)=51.5*1e-6/32;
% OriImg(Cder01Id)=51.5/32;
% 圆锥1
Cone01R=MainR/8;
Cone01H=MainR/8;
zoomCone01=[-MainR/2 -MainR/2 -48]+CId;
Cone01Id=(TX-zoomCone01(1)).^2+(TY-zoomCone01(2)).^2-(TZ-zoomCone01(3)-Cone01H).^2/4<0;
Cone01Id=(abs(TZ-zoomCone01(3))<Cone01H)+Cone01Id>1;
OriImg(Cone01Id)=51.5*1e-6/32;
% OriImg(Cone01Id)=51.5/32;
%% 生成正投图
tic;
ProjImgO=Radon3D(OriImg,theta);
toc;
%% 设置探测器的摆动和跳动
m_x=round(rand(1,nviews)*20-10);%-4~4的随机正整数
m_y=round(rand(1,nviews)*20-10);%-4~4的随机正整数
theta_z=0.1*round(rand(1,nviews)*20-10);%-1~1，间隔0.1
px=zeros(nbins+20,Isize+20,nviews);%扩充矩阵
px(11:nbins+10,11:Isize+10,:)=ProjImgO;
[X,Y]=meshgrid(-Isize/2+0.5:Isize/2-0.5,-Isize/2+0.5:Isize/2-0.5);%图像坐标
p_xy=zeros(nbins,Isize,nviews);%径跳和端跳之后的正投图
p_z=zeros(nbins,Isize,nviews);%摆动之后的正投图
k=12;

%% 生成摆动和跳动后的正投图

for i=1:10
    tic;
    p_xy(:,:,i)=px(11+m_x(i):Isize+m_x(i)+10,11+m_y(i):Isize+10+m_y(i),i);
%     p_z(:,:,i)=Rotate1(p_xy(:,:,i),k,theta_z(i));
    toc;
end

% for i=1:18
%     tic;
%     %放大图片*10
%     tt=imresize(ProjImgO(:,:,i),10);
%     %定义平移矩阵
%     PC=zeros(Isize*10+80,Isize*10+80);
%     PC(41:Isize*10+40,41:Isize*10+40)=tt;
%     p_xy1=zeros(Isize*10,Isize*10);
%     p_xy1=PC(41+round(m_x(i)*10):Isize*10+round(m_x(i)*10)+40,41+round(m_y(i)*10):Isize*10+40+round(m_y(i)*10));
%     p_xyy(:,:,i)=imresize(p_xy1,1/10);
% %     p_z(:,:,i)=Rotate1(p_xyy,k,theta_z(i));
%     toc;
% end
