function [ Array ] = DragLine( Img,theta,PosA,PosB )
%DragLine �Ӷ�άͼ�г��һ���߹���һά����
%   Img 2Dͼ��
%   theta ��ת��(0~180��)
%   PosA ��ʼ��
%   PosB ��ֹ��
% �㷨
% ��ͼ������Ϊԭ�㣬���������������ΪY�ᣬ���������������ΪX�ᣬ����ֱ������ϵ
% 1.���ݸ����������յ������ӵ��߶������������أ����в�ֵȡ��������һά����
% 2.�����������ʼ�����ֹ�㣬����ݸ����ĽǶȣ���ԭ��Ϊ����,��ͼ������Բ��ֱ��Ϊ���ȣ�����ȡ��
% 3.���ͬʱ�����ǶȺ���ʼ�㣬���Ը�������ʼ��Ϊ׼

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

% ѡ���Ƿ���ʾͼƬ
if 0
    img_rgb=repmat(Img,[1,1,3]);
    img_rgb=insertShape(img_rgb,'Line',[PosA(1) PosA(2) PosB(1) PosB(2)],'LineWidth',1);
    figure,imshow(img_rgb,[])
    figure,plot(Array)
end





end

