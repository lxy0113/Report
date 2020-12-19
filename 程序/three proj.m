clc;
clear;
%% 参数设置
s=64;
sod=300;
sdd=897.987;
odd=sdd-sod;
nbins=128;
cellsize=0.2;
nviews=180;
dis=1;
angle_step=180/nviews;
half_detector=nbins*cellsize/2;
theta=atan(half_detector/sdd);

%% 构建模型
M1=fix(s/2)-17;
I = zeros(s,s,s);
for i=1:s
    for j=1:s
        for k=1:s
            if((i-M1)^2+(j-M1)^2+(k-M1-3)^2<=100)
                I(i,j,k)=0.3;
%                 if((i-M1)^2+(j-M1)^2+(k-M1)^2<=1000)
%                     I(i,j,k)=1;
%                 end
            end
        end
    end
end
%%
p=zeros(nviews,nbins,s);
for i=1:s
    im=pro_3D(I,dis,angle_step,nviews,nbins);
    imshow(im,[]);
    title(['k=',num2str(i)]);
    pause(0.5);  
end