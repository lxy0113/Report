clc;
clear;
%% 参数设置
N=64;
M=N;
K=N;
nbins=N;
nviews=180;
dis=1;
z_angle=180;
angle_step=z_angle/nviews;
theta=0:angle_step:z_angle-angle_step;
%% 构建模型
% M1=fix(N/2)-17;
I = zeros(N,N,N);
% for i=1:N
%     for j=1:N
%         for z=1:N
%             if((i-15)^2+(j-34)^2+(z-10)^2<=64)
%                 I(i,j,z)=1;
%             end
%         end
%     end
% end 
I(1:5,20:30,54:64)=1;
%% 正投
proj=zeros(N,nviews,N);
for i=1:N
    p=para1_2D(I(:,:,i),nviews,nbins,N,theta);
    imshow(p,[]);
    title(['i=',num2str(i)]);
    pause(0.5);
%     for j=1:nviews
%         for k=1:N
%             proj(i,j,k)=p(j,k);
%         end
%     end 
%     imshow(proj(:,:,i),[])
%     title(['i=',num2str(i)]);
%     pause(0.5);
end
% 每个角度下的正投图
projX=zeros(N,N,nviews);
for i=1:nviews
    for j=1:N
        for k=1:N
            projX(j,k,i)=proj(j,i,k);
        end
    end
    imshow(projX(:,:,i),[])
    title(['i=',num2str(i)]);
    pause(0.5);
end
%% 考虑探测器的摆动和跳动
N_step=N/nbins;
M_step=M/nbins;
K_step=K/nbins;
m_x=round(rand(1,nviews)*2);
% m_y=round(rand(1,nviews)*2);
% theta_z=0.1*round(rand(1,nviews)*2);
% m_x=zeros(nviews);
m_y=zeros(nviews);
theta_z=zeros(nviews);
[X1,Y1]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
[Rx,Ry,RZ]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2,-K/2+K_step/2:K_step:K/2-K_step/2);
pX=zeros(nbins+20,nbins+20);
pro=zeros(N,N,nviews);
for i=1:nviews
    for j=11:nbins+10
        for k=11:nbins+10
            pX(j,k)=projX(j-10,k-10,i);
        end
    end
    ppX=pX((11-m_x(i)):(nbins+10-m_x(i)),(11-m_y(i)):(nbins+10-m_y(i)));
%     title([' m_x=',num2str(m_x(i)),'m_y=',num2str(m_y(i))]);
    R1=X1.*cosd(theta_z(i))+Y1.*sind(theta_z(i));
    R2=-X1.*sind(theta_z(i))+Y1.*cosd(theta_z(i));
    p1=interp2(X1,Y1,ppX,R1,R2,'linear',0);
    for j=1:N
        for k=1:N
            pro(j,k,i)=p1(j,k);
        end
    end   
end
% 旋转后的正投图
proj_x=zeros(N,nviews,N);
for i=1:N
    for j=1:nviews
        for k=1:N
            proj_x(k,j,i)=pro(i,k,j);
        end
    end
end
%% 重建
I0=zeros(N,N,N);
k_final=10;
for i=1:N
    tic;
    pp=iproj_2D(proj_x,N,nviews,nbins,theta,i,dis,k_final);
    for j=1:N
        for k=1:N
            I0(i,j,k)=pp(j,k);
        end
    end
    toc;
end
er=abs(I-I0);
