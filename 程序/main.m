clc;
clear;
%% 参数设置
s=64;
sod=300;
sdd=897.987;
odd=sdd-sod;
nbins=64;
cellsize=0.2;
nviews=180;
dis=1;
angle_step=180/nviews;
half_detector=nbins*cellsize/2;
theta=atan(half_detector/sdd);

%% 构建模型
M1=fix(s/2)-17;
I1 = zeros(s,s,s);
for i=1:s
    for j=1:s
        for k=1:s
            if((i-M1)^2+(j-M1)^2+(k-M1-3)^2<=100)
                I1(i,j,k)=0.3;
%                 if((i-M1)^2+(j-M1)^2+(k-M1)^2<=1000)
%                     I(i,j,k)=1;
%                 end
            end
        end
    end
end

[M,N,K]=size(I);
N_step=N/nbins;
M_step=M/nbins;
K_step=K/nbins;
[X,Y,Z]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5,-K/2+0.5:K/2-0.5);
[Rx,Ry,RZ]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2,-K/2+K_step/2:K_step:K/2-K_step/2);
I=interp3(X,Y,Z,I1,Rx,Ry,RZ,'linear',0);

%%
% p=zeros(nviews,nbins,s);
% for i=1:s
%     image=I(:,:,i);
%     [M,N]=size(image);
%     half_N=N/2;
%     pixlsize=(half_detector*sod/sqrt(half_detector^2+sdd^2))/half_N;
%     im=pro_2D(image,dis,angle_step,nviews,nbins);
% %     imshow(im,[]);
% %     title(['k=',num2str(i)]);
% %     pause(0.5);
%     p(:,:,i)=im;    
% end

%%
% for k=1:s
% zero_view=zeros(nbins,s);
% for i=1:nbins
%     for j=1:s
%         zero_view(i,j)=p(k,i,j);
%     end
% end
% one_zview=zero_view';
% imshow(zero_view,[]);
% title(['旋转角=',num2str(k),'°下的正投图']);
% pause(0.5);
% end
