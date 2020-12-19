clc;
clear;
%% 参数设置
s=256;
sod=300;
sdd=897.987;
odd=sdd-sod;
nbins=s;
cellsize=0.2;
nviews=180 ;
dis=1;
z_angle=180;
angle_step=z_angle/nviews;
half_detector=nbins*cellsize/2;
theta=atan(half_detector/sdd);

%% 构建模型
M1=fix(s/2)-17;
I = zeros(s,s,s);
[Ix,Iy,Iz] = meshgrid(-s/2+0.5:s/2-0.5);
pos = [32,32,32-3];
r = 10;
I((Ix-pos(1)).^2+(Iy-pos(2)).^2+(Iz-pos(3)).^2<=r^2) = 1;

%% 旋转
% [M,N,K]=size(I);
% theta=45;
% [Rx,Ry,Rz]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5,-K/2+0.5:K/2-0.5);
% Xray=Rx.*cosd(theta)+Rz.*sind(theta);
% Zray=-Rx.*sind(theta)+Rz.*cosd(theta);
% Yray=Ry;
% I=interp3(Rx,Ry,Rz,I,Xray,Yray,Zray,'linear',0);

%% 正投
im=pro_3D(I,dis,angle_step,z_angle,nviews,nbins);
for k=1:1
    ii=zeros(nbins,nbins);
    for i=1:nbins
        for j=1:nbins
            ii(i,j)=im(k,i,j);
        end
    end
    z=ii';
    %展示各个角度下的正投图片
%     imshow(ii,[]);
%     title(['旋转角=',num2str(k),'°的正投图']);
%     pause(0.5);
    save z;
end