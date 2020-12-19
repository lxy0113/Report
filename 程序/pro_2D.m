function [proj]=pro_2D(image,dis,angle_step,nviews,nbins)
%% Õ¯∏Ò¿Î…¢ªØ
[M,N]=size(image);
N_step=N/nbins;
M_step=M/nbins;
[X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
[Rx,Ry]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2);
angle=0:angle_step:180-angle_step;
proj=zeros(nviews,nbins);
for i=1:nviews
    proj(i,:)=dis*projection(image,X,Y,Rx,Ry,angle(i));
end
% figure(2)
% imshow(proj,[]);
end