%% 测试0和90的振幅和相位
% a=p_z(:,:,1);
% b=ProjImg(:,:,1);
% P2_fft=fftshift(fft2(a'));
% % 分实部和虚部两部分插值
% Real_P2=real(P2_fft);
% Image_P2=imag(P2_fft);
% % 设置旋转的角度,旋转矩阵
% theta1=-0.3;
% Real_P21=Rotate1(Real_P2,1,theta1);
% Image_P21=Rotate1(Image_P2,1,theta1);
% C=Real_P21(65,:)+(Image_P21(65,:))*i;%选择与一维方向相同的角度
% ab=abs(C);
% ang=angle(C);
% % figure
% % plot(C);
% % title('中心');
% e=[1,91];
% [ab0,ang0]=furo(a');
% [ab1,ang1]=furo(b');
% v=[ab(65),ab0(65),ab1(65)];
% x=[ang(65)*128/(2*pi),ang0(65)*128/(2*pi),ang1(65)*128/(2*pi)];
% figure(1)
% plot(e,v,'*');
% title('0°和90°振幅');
% figure(2)
% plot(e,x,'*');
% title('0°和90°相位');

% k=12;
% aa=Rotate1(a,k,-0.3);
% bb=Rotate1(b,k,-0.8);
% [ab01,ang01]=furo(aa');
% [ab11,ang11]=furo(bb');
% v1=[ab01(64),ab11(64)];
% x1=[ang01(64)*128/(2*pi),ang11(64)*128/(2*pi)];
% figure(3)
% plot(e,v1,'*');
% title('0°和90°正投逆向旋转0.3和0.9度之后振幅的变化');
% figure(4)
% plot(e,x1,'*');
% title('0°和90°正投逆向旋转0.3和0.9度之后相位的变化');

%% 匹配(找基准)
% a=p_z(:,:,1);
% b=p_z(:,:,91);
% [zf1,xw1]=mate(a,12);
% tic;
% [zf2,xw2]=mate(b,12);
% toc;


% zf11=zf1(1:21,1);
% xw11=xw1(1:21,1);
% zf21=zf2(1:21,1);
% xw21=xw2(1:21,1);
% % scrvar=sprintf('zf11');
% % dstnme=sprintf('zf11.csv');
% % eval(['save ',dstnme,'zf11 ',scrvar,' -ascii']);
% % scrvar=sprintf('zf21');
% % dstnme=sprintf('zf21.csv');
% % eval(['save ',dstnme,'zf21 ',scrvar,' -ascii']);
% % scrvar=sprintf('xw11');
% % dstnme=sprintf('xw11.csv');
% % eval(['save ',dstnme,'xw11 ',scrvar,' -ascii']);
% % scrvar=sprintf('xw21');
% % dstnme=sprintf('xw21.csv');
% % eval(['save ',dstnme,'xw21 ',scrvar,' -ascii']);

% save p_z;
%% 找所有角度下的m_x和theta_z
% o=p_z(:,:,1);
% [t,y]=mate(o,12);%k=12,是图像放缩比例
% rot=zeros(180,2);
% rot(1,1)=0.5;%第一列表示旋转的角度
% rot(1,2)=y(16);%第二列表示与0°的端跳差
% r=-2:0.1:2;
% [xx,count]=size(r);
% for i=2:180
%     tic;
%     [t1,y1]=mate(p_z(:,:,i),12);
% %   
% %         imshow(p_z(:,:,i),[]);
% %         pause(0.2);
%    
%     %找最小振幅差
%     c1=100;
%     z=1;
%     for j=1:count
%         c=abs(t(16)-t1(j));
%         if(c<c1)
%             c1=c;
%             z=j;
%         end
%     end
%     xw_cha=y1(z);
%     rot(i,1)=-r(z);
%     rot(i,2)=round(xw_cha);
%     toc;
% end
% 
% pp=theta_z';
% 
% cha_theta=pp(:,1)-rot(:,1);
% figure
% plot(cha_theta);
% title('摆角误差');


% %保存所求m_x和theta_z;
% % scrvar=sprintf('rot');
% % dstnme=sprintf('rot.csv');
% % eval(['save ',dstnme,'rot ',scrvar,' -ascii']);
% % 保存变量值
% 
% label=zeros(180,3);
% label(:,1)=1-m_x;
% label(:,2)=m_y;
% label(:,3)=theta_z;
% cham_x=label(:,1)-rot(:,2);
% chatheta_z=label(:,3)-rot(i,1);
% figure(1)
% plot(cham_x);
% title('m_x(端跳)的误差');
% figure(2)
% plot(chatheta_z);
% title('theta_z(摆角)的误差')

% scrvar=sprintf('label');
% dstnme=sprintf('rot.csv');
% eval(['save ',dstnme,'rot ',scrvar,' -ascii']);

%% 质心运动轨迹找m_y(径跳)
nbins=Isize;
nviews=180;
time=1:180;
[x,y]=matem_y(p_z,rot,jz,nbins,nviews);
figure
plot(time,x,'*');
title('质心运动轨迹');
% 用拟合曲线的方式
e=0:179;
fx=zeros(180,1);
for i=1:180
    fx(i,1)=255.6+3.103*cos(e(i)*0.02236)+0.06544*sin(e(i)*0.02236);
end
m_yyy=-round(x'-fx);
cham_y=zeros(180,1);
cham_y=m_y'-m_yyy;
figure
plot(cham_y);
title('径跳误差');

