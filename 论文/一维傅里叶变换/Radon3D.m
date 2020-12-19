function [ProjImg] = Radon3D( OriImg,theta,dDetector,dRotator,Dlength,Method)
%Radon3D 三维图像的Radon投影
%   OriImg 原图
%   theta 旋转角设定
%   dDetector 探测器间隔
%   dRotator 样品台
%   Dlength 探测器长度

if nargin==2
    dDetector=1;
    dRotator=1;
    Dlength=size(OriImg,1)*dDetector;
    Method=1;    
end
DN=floor(Dlength/dDetector);

RN=size(OriImg,3);
AN=length(theta);
ProjImg=zeros(DN,DN,AN);

for h=1:RN
    ProjImg_h=Radon2D(OriImg(:,:,h),theta,dDetector,dRotator,Dlength,Method);
    ProjImg(h,:,:)=ProjImg_h;
end

