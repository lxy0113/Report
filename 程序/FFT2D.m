function [ fX,realfX,imagfX,absfX,anglefX ] = FFT2D( X,Augtime,RotateAngle )
%FFT2D 二维的快速傅立叶变换（Fast Fourier Transform）
%   X 二维数据
%   Augtime 将原始二维数据周围填充0，图片尺寸的放大倍率
%   RotateAngle 将原图旋转的角度
%   fX 傅立叶变换结果
%   realfX fX的实部
%   imagfX fX的虚部
%   absfX fX的幅度
%   anglefX fX的相角
% edit in 2019.11.25

%% 参数的设定
if nargin==1
    Augtime=1;
    RotateAngle=0;
end
if nargin==2
    RotateAngle=0;
end
Isize=max(size(X));

%% 对原始数据进行旋转和填充
%对X进行旋转
X=imrotate(X,RotateAngle,'crop','bilinear');
%对X进行填充
Asize=Isize*Augtime;% 放大尺寸
X2=zeros(Asize);
centgrididx=Asize/2-Isize/2+1:Asize/2+Isize/2;%中心区域索引
X2(centgrididx,centgrididx)=X;
%% Fourier变换
fX=fft2(fftshift(X2));
realfX=real(fX);
imagfX=imag(fX);
absfX=abs(fX);
anglefX=angle(fX);
end

