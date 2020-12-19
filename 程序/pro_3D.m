function [proj]=pro_3D(image,dis,angle_step,z_angle,nviews,nbins)
%% Õ¯∏Ò¿Î…¢ªØ
[M,N,K]=size(image);
N_step=N/nbins;
M_step=M/nbins;
K_step=K/nbins;
[X,Y,Z]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5,-K/2+0.5:K/2-0.5);
[Rx,Ry,RZ]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2,-K/2+K_step/2:K_step:K/2-K_step/2);
angle=0:angle_step:z_angle-angle_step;
proj=zeros(nviews,nbins,nbins);
for i=1:nviews
    proj(i,:,:)=dis*proj3D(image,X,Y,Z,Rx,Ry,RZ,angle(i));
end
% figure(2)
% imshow(proj,[]);
end