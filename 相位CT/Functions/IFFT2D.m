function [ Y ] = IFFT2D( fX,Augtime,RotateAngle)
%IFFT2D 对频域的二维信号进行傅立叶逆变换
%   fX 频域的二维信号
%   Augtime 扩大的倍率（参考函数FFT2D定义）
%   RotateAngle 旋转的角度
%   Y 逆变换结果
% edit in 2019.11.25
%% 参数的设定
if nargin==1
   Augtime=1;
   RotateAngle=0;
end

if nargin==2
   RotateAngle=0; 
end

Isize=max(size(fX));% 原始图像大小
Ssize=Isize/Augtime;% 裁剪图的大小
centgrididx=Isize/2-Ssize/2+1:Isize/2+Ssize/2;% 按Ssize大小在Isize的中心取样索引

%% 频域图像的旋转与逆变换
% 旋转
fX2=imrotate(fftshift(fX),RotateAngle,'crop','bilinear');
fX2=fftshift(fX2);
% 逆变换
X2=fftshift(ifft2(fX2));
X2=real(X2);
% 按比例裁剪
Y=X2(centgrididx,centgrididx);


end

