%% 傅里叶频率配准
clc;
clear;
load y;
% load z;

load proj_2;
% load proj_90;
% load proj_900;
% load proj_1;
% 
% a=proj_2;
% b=proj_90;%转1°
% c=proj_900;
% 

z=proj_2;
% y=b;


%一个角度
oo=pro_2D(y',dis,angle_step,1,nbins);
plot(oo);
[mo,index1]=max(oo);
yy=pro_2D(z',dis,angle_step,1,nbins);
figure
plot(yy);
[mz,index2]=max(yy);
fX=fftshift(fft(oo));
realfX=real(fX);
imagfX=imag(fX);
absfX=abs(fX);
anglefX=angle(fX);
fX1=fftshift(fft(yy));
realfX1=real(fX1);
imagfX1=imag(fX1);
absfX1=abs(fX1);
anglefX1=angle(fX1);