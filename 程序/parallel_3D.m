% clc;
% clear;
% %% 参数设置
% N=64;
% nbins=N;
% nviews=180;
% dis=1;
% z_angle=180;
% angle_step=z_angle/nviews;
% %% 构建模型
% M1=fix(N/2)-17;
% I = zeros(N,N,N);
% for i=1:N
%     for j=1:N
%         for z=1:N
%             if((i-16)^2+(j-16)^2+(z-15)^2<=100)
%                 I(i,j,z)=1;
%             end
%         end
%     end
% end           
% % [Ix,Iy,Iz] = meshgrid(-N/2+0.5:N/2-0.5);
% % pos = [-32,-32,-32];
% % r = 10;
% % I((Ix-pos(1)).^2+(Iy-pos(2)).^2+(Iz-pos(3)).^2<=r^2) = 1;
% % I(120:136,120:136,120:136)=1;
% %% 平行束正投
% im=zeros(nviews,nbins,nbins);
% angle=0:angle_step:z_angle-angle_step;
% tic;
% % im=pro1_3D(I,dis,angle_step,z_angle,nviews,nbins);
% % for i=1:nviews
% %     for j=1:nbins
% %         for k=1:nbins
% %             ima(j,k)=im(180,j,k);
% %         end
% %     end
% %     imshow(ima,[]);
% %     pause(0.5);
% % end
% % 
% % for i=1:nviews
% %     for j=1:nbins
% %         for k=1:nbins
% %             img(j,k,i)=ima(k,j);
% %         end
% %     end
% % end
% % 
% % toc;
% for i=1:nviews
%     im(i,:,:)=iproj_3D(I,dis,angle(i),nviews,nbins,i);
%     ima=zeros(nbins,nbins);
%     for j=1:nbins
%         for k=1:nbins
%             ima(j,k)=im(i,j,k);
%         end
%     end
% %     imshow(ima,[])
% %     title(['i=',num2str(i)]);
% %     pause(0.5);
% end
% % save im;
% 
% %     for j=1:nbins
% %         for k=1:nbins
% %             ima90(j,k)=im(90,j,k);
% %         end
% %     end
% %     save ima90;


% %% 反投
I0=zeros(N,N,N);
M=N;
K=N;
N_step=1;
M_step=1;
[X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
[Rx,Ry]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2);
k_final=1;
for iter=1:k_final
    tic;
    for i=1:nviews
        % p表示真实的第i个角度下的正投图
        % x表示重建物体第i个角度下的正投图
        %error表示p和x误差
        for j=1:nbins
            for k=1:nbins
                ima(j,k)=im(i,j,k);
            end
        end  
%         imshow(ima,[]);
%         pause(0.5);
        rrr=dis*iproj_3D(I0,dis,angle(i),nviews,nbins,i);
% %       
%          figure
%         imshow(rrr,[]);
%         title(['k=',num2str(i)]);
        pause(0.5);
%         error=(im(i,:,:)-dis*iproj_3D(I0,dis,angle(i),nviews,nbins,i))/N;
        error=(ima-rrr)/N;
%         figure
%         imshow(error,[]);
%         title('误差');
%         for j=1:nbins
%             for k=1:nbins
%                 error(j,k)=error(i,j,k);
%             end
%         end
        Xray=Rx.*cosd(angle(i))+Ry.*sind(angle(i));
        Yray=-Rx.*sind(angle(i))+Ry.*cosd(angle(i));
        orth=interp2(X,Y,error,Xray,Yray,'linear',0); 
%         figure
%         imshow(orth,[]);
%         pause(0.5);
        O=zeros(N,N,N);
        for j=1:N
            O(:,:,j)=orth;
        end
        I0=I0+O;

        
        
    end   
  
    toc;
end
    I0(I0<0)=0; 
    I0(I0>1)=1;

