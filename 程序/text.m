% clc;
% clear;
%% ��������
N=256;
nbins=N;
nviews=180;
dis=1;
z_angle=180;
angle_step=z_angle/nviews;
%% ����ģ��
I=zeros(N,N,N);
center=[-N/4,-N/4,-N/4];
r=8;
[A,B,C]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);
I((A-center(1)).^2+(B-center(2)).^2+(C-center(3)).^2<=r^2)=1;            
%% ƽ������Ͷ
im1=zeros(nbins,nbins,nviews);
angle=0:angle_step:z_angle-angle_step;
tic;
im1=pro1_3D(I,dis,angle_step,z_angle,nviews,nbins);
toc;
% for i=1:nviews
%     imc(:,:,i)=im(i,:,:);
% end
% for i=1:nviews
%     im(:,:,i)=iproj_3D(I,dis,angle(i),nviews,nbins,i);
%     
%     ima=zeros(nbins,nbins);
%     for j=1:nbins
%         for k=1:nbins
%             ima(j,k)=im(j,k,i);
%         end
%     end
%     imshow(ima',[])
%     pause(0.5);
% end
% save im;
% 
%     for j=1:nbins
%         for k=1:nbins
%             ima90(j,k)=im(90,j,k);
%         end
%     end
%     save ima90;
% 
% 
% %% ��Ͷ
% I0=zeros(N,N,N);
% M=N;
% K=N;
% N_step=1;
% M_step=1;
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
% [Rx,Ry]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2);
% k_final=1;
% for iter=1:k_final
%     tic;
%     for i=1:nviews
%         % p��ʾ��ʵ�ĵ�i���Ƕ��µ���Ͷͼ
%         % x��ʾ�ؽ������i���Ƕ��µ���Ͷͼ
%         %error��ʾp��x���
%         error=(im(i,:,:)-dis*iproj_3D(I0,dis,angle(i),nviews,nbins,i))/N;
%         for j=1:N
%             for k=1:N
%                 erro(j,k)=error(i,j,k);
%             end
%         end
%         Xray=Rx.*cosd(angle(i))+Ry.*sind(angle(i));
%         Yray=-Rx.*sind(angle(i))+Ry.*cosd(angle(i));
%         orth=interp2(X,Y,erro,Xray,Yray,'linear',0);  
%         I0=I0+orth;
%     end   
%     I0(I0<0)=0;
%     I0(I0>1)=1;  
%     toc;
% end


