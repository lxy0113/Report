function [ ProjImg ] = Radon2D( OriImg,theta,dDetector,dRotator,Dlength,Method)
%Radon2D 二维图像的Radon投影
%   OriImg 原图
%   theta 旋转角设定
%   dDetector 探测器间隔
%   dRotator 样品台
%   Dlength 探测器长度


if nargin==2
   dDetector=1;
   dRotator=1;
   Dlength=size(OriImg,1);
   Method=1;
end

if nargin==3
    dRotator=1;
    Dlength=size(OriImg,1);
    Method=1;
end

Method=2;

if Method==1
Isize=size(OriImg,1);
Iangle=length(theta);
Psize=floor(Dlength/dDetector);
ProjImg=zeros(Psize,Iangle);

Rlabel=(-Isize/2+0.5:Isize/2-0.5)*dRotator;
[X,Y]=meshgrid(Rlabel);
Plabel=(-Psize/2+0.5:Psize/2-0.5)*dDetector;
[RayX0,RayY0]=meshgrid(Plabel);

OriImg_p=interp2(X,Y,OriImg,RayX0,RayY0,'linear',0);

for i=1:Iangle
    RayX=RayX0*cosd(theta(i))+RayY0*sind(theta(i));
    RayY=-RayX0*sind(theta(i))+RayY0*cosd(theta(i));
    OriImg_pt=interp2(RayX0,RayY0,OriImg_p,RayX,RayY,'linear',0);
    ProjImg(:,i)=sum(OriImg_pt,1);
%     figure(1)
%     imshow(ProjImg,[])
%     pause(0.01)

end


end


if Method==2
   Isize=size(OriImg,1);
   ProjImg=radon(OriImg,theta); 
   Psize=size(ProjImg,1);
   ProjImg=ProjImg(floor(Psize/2)-Isize/2+2:floor(Psize/2)+Isize/2+1,:);
end






end

