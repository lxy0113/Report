function [ Array ] = DragLine( Img,theta,PosA,PosB )
%DragLine 从二维图中抽出一条线构成一维数组
%   Img 2D图像
%   theta 旋转角(0~180度)
%   PosA 起始点
%   PosB 终止点
% 算法
% 以图像中心为原点，矩阵的行索引方向为Y轴，矩阵的列索引方向为X轴，建立直角坐标系
% 1.根据给定的起点和终点所连接的线段所经过的像素，进行插值取样，构成一维数组
% 2.如果不给定起始点和终止点，则根据给定的角度，以原点为中心,以图像内切圆的直径为长度，划线取样
% 3.如果同时给定角度和起始点，则以给定的起始点为准

Isize=max(size(Img));
% theta_arc=theta/180*pi;

if nargin==2
    RN=Isize/2;
    PosA=[RN*sind(theta),RN*cosd(theta)];
    PosB=[-RN*sind(theta),-RN*cosd(theta)];
    PosA(1)=PosA(1)+Isize/2;
    PosA(2)=-PosA(2)+Isize/2;
    PosB(1)=PosB(1)+Isize/2;
    PosB(2)=-PosB(2)+Isize/2;
    
    
    
    PosA(1)=PosA(1)+0.5;
    PosB(1)=PosB(1)+0.5;
    
    PosB(2)=PosB(2)-0.5;
    PosA(2)=PosA(2)+0.5;
    
%     PosB(2)=PosB(2)+0.5;
%     PosA(2)=PosA(2)+0.5;
    
end
LineX=linspace(PosB(1),PosA(1),Isize);
LineY=linspace(PosB(2),PosA(2),Isize);
% LineX=LineX+0.5;

[X,Y]=meshgrid(1:Isize,1:Isize);
X=X-0.5;Y=Y-0.5;

Array=interp2(X,Y,Img,LineX,LineY,'bilinear',0);
Array=Array(end:-1:1);

% 选择是否显示图片
if 0
    img_rgb=repmat(Img,[1,1,3]);
    img_rgb=insertShape(img_rgb,'Line',[PosA(1) PosA(2) PosB(1) PosB(2)],'LineWidth',1);
    figure,imshow(img_rgb,[])
    figure,plot(Array)
end





end

