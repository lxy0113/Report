function [ fX,realfX,imagfX,absfX,anglefX ] = FFT2D( X,Augtime,RotateAngle )
%FFT2D ��ά�Ŀ��ٸ���Ҷ�任��Fast Fourier Transform��
%   X ��ά����
%   Augtime ��ԭʼ��ά������Χ���0��ͼƬ�ߴ�ķŴ���
%   RotateAngle ��ԭͼ��ת�ĽǶ�
%   fX ����Ҷ�任���
%   realfX fX��ʵ��
%   imagfX fX���鲿
%   absfX fX�ķ���
%   anglefX fX�����
% edit in 2019.11.25

%% �������趨
if nargin==1
    Augtime=1;
    RotateAngle=0;
end
if nargin==2
    RotateAngle=0;
end
Isize=max(size(X));

%% ��ԭʼ���ݽ�����ת�����
%��X������ת
X=imrotate(X,RotateAngle,'crop','bilinear');
%��X�������
Asize=Isize*Augtime;% �Ŵ�ߴ�
X2=zeros(Asize);
centgrididx=Asize/2-Isize/2+1:Asize/2+Isize/2;%������������
X2(centgrididx,centgrididx)=X;
%% Fourier�任
fX=fft2(fftshift(X2));
realfX=real(fX);
imagfX=imag(fX);
absfX=abs(fX);
anglefX=angle(fX);
end

