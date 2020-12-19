%% theta变化
%% 导入图片
load ima1;
load ima90;
% load proj_901;
% load proj_1;
% load proj_590;
load proj_1;
load proj_2;
load proj_90;

a1= proj_1;
a=proj_2;
b=proj_90;
% c=proj_901;%摆角为1°，其他为0
% d=proj_590;%端跳为5，其他为0
imshow(a1,[]);
figure
imshow(a,[]);
figure
imshow(b,[]);
%% 傅里叶变换，求实部、虚部、振幅、相位
[Re0,Im0,ab0,ang0]=furo(a1);
[Re1,Im1,ab1,ang1]=furo(a);
% [Re2,Im2,ab2,ang2]=furo(b);
% [Re3,Im3,ab3,ang3]=furo(c);
% [Re4,Im4,ab4,ang4]=furo(d);

zf=[ab0(128),ab1(128)];
xw=[ang0(128),ang1(128)];

% dd=(ang2(128)-ang4(128))*256/(2*pi);