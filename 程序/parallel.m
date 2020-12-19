clc;
clear;
%% 生成图像（导入图像）
N=256;
image=phantom(N);
figure(1)
imshow(image,[]);
%% 参数设置
sod=300;
sdd=897.987;
odd=sdd-sod;
nbins=256;
cellsize=0.2;
nviews=130;
dis=1;
angle_step=180/nviews;
[M,N]=size(image);
half_detector=nbins*cellsize/2;
half_N=N/2;
pixlsize=(half_detector*sod/sqrt(half_detector^2+sdd^2))/half_N;
theta=atan(half_detector/sdd);
%% 网格离散化
[X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
[Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);
angle=0:angle_step:180-angle_step;
%% 正投影
proj=zeros(nviews,nbins);
for i=1:nviews
    proj(i,:)=dis*projection(image,X,Y,Rx,Ry,angle(i));
end
% figure(2)
% imshow(proj,[]);


