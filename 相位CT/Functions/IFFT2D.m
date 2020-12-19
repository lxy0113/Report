function [ Y ] = IFFT2D( fX,Augtime,RotateAngle)
%IFFT2D ��Ƶ��Ķ�ά�źŽ��и���Ҷ��任
%   fX Ƶ��Ķ�ά�ź�
%   Augtime ����ı��ʣ��ο�����FFT2D���壩
%   RotateAngle ��ת�ĽǶ�
%   Y ��任���
% edit in 2019.11.25
%% �������趨
if nargin==1
   Augtime=1;
   RotateAngle=0;
end

if nargin==2
   RotateAngle=0; 
end

Isize=max(size(fX));% ԭʼͼ���С
Ssize=Isize/Augtime;% �ü�ͼ�Ĵ�С
centgrididx=Isize/2-Ssize/2+1:Isize/2+Ssize/2;% ��Ssize��С��Isize������ȡ������

%% Ƶ��ͼ�����ת����任
% ��ת
fX2=imrotate(fftshift(fX),RotateAngle,'crop','bilinear');
fX2=fftshift(fX2);
% ��任
X2=fftshift(ifft2(fX2));
X2=real(X2);
% �������ü�
Y=X2(centgrididx,centgrididx);


end

