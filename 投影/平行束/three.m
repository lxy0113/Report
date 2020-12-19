clc;
clear;
%% 参数设置
N=64;
nbins=N;
nviews=180;
dis=1;
z_angle=180;
angle_step=z_angle/nviews;
%% 构建模型
M1=fix(N/2)-17;
I = zeros(N,N,N);
for i=1:N
    for j=1:N
        for z=1:N
            if((i-8)^2+(j-32)^2+(z-15)^2<=100)
                I(i,j,z)=1;
            end
        end
    end
end 
I0=zeros(N,N,N);
for i=1:N
    p=para_2D(I,nviews,nbins,N,i);
    imshow(p,[]);
    title(['i=',num2str(i)]);
    for j=1:N
        for k=1:N
            I0(i,j,k)=p(j,k);
        end
    end
end