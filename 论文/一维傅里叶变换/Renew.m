function [rot,er]=Renew(ProjImg,N,theta_z,m_x,m_y,x1,y1)
%% 验证摆动和跳动对振幅和相位的影响
% a=p_z(:,:,1);
% b=p_z(:,:,19);
% e=[0,18];
% [ab0,ang0]=furo(a');
% [ab1,ang1]=furo(b');
% v=[ab0(N/2),ab1(N/2)];
% x=[ang0(N/2)*N/(2*pi),ang1(N/2)*N/(2*pi)];
% for i=1:180
%     a=p_z(:,:,i);
%     [ab0,ang0]=furo(a');
%     zf(i)=ab0(N/2);
%     xw(i)=ang0(N/2)*N/(2*pi);
%     
% end
% er=xw+m_x;
% figure(1)
% plot(zf);
% xlabel('投影角度');
% ylabel('振幅');
% title('振幅对比');
% figure(2)
% plot(xw);
% xlabel('投影角度');
% ylabel('相位');
% title('相位对比');
% figure(3);
% plot(er);
% xlabel('投影角度');
% ylabel('相位');
% title('相位与端跳差');
% b=ProjImg(:,:,2);
% for k=1:20
% bb=Rotate1(b,k,1);
% bbb=Rotate1(bb,k,-1);
% [ab0,ang0]=furo(b');
% [ab1,ang1]=furo(bbb');
% v(k)=ab0(256)-ab1(256);
% x(k)=ang0(256)*512/(2*pi)-ang1(256)*512/(2*pi);
% end
% figure(1)
% plot(v);
% title('随着放缩倍数变化的振幅差');
% figure(2)
% plot(x);
% title('随着放缩倍数变化的相位差');
%% 反向旋转匹配
k=12;
c=-1:0.1:1;
[cm,count]=size(c);
a=p_z(:,:,1);
b=p_z(:,:,3);
[zf1,xw1]=mate(a,k,c);
[zf2,xw2]=mate(b,k,c);
t=1000;
for i=1:count
    for j=1:count
        dd=abs(zf1(i)-zf2(j));
        if(dd<t)
            t=dd;
            cx=i;
        end
    end
end

%% 找所有角度下的m_x和theta_z
k=12;
o=p_z(:,:,1);
[t,y]=mate(o,12,c);%k=12,是图像放缩比例
count2=180;
rot=zeros(count2,2);
rot(1,1)=-c(cx);%第一列表示旋转的角度
rot(1,2)=round(y(cx));%第二列表示与0°的端跳差
for i=2:count2
    tic;
    [t1,y1]=mate(p_z(:,:,i),k,c);
    %找最小振幅差
    c1=100;
    z=1;
    for j=1:21
        cc=abs(t(cx)-t1(j));
        if(cc<c1)
            c1=cc;
            z=j;
        end
    end
    xw_cha=y1(z);
    rot(i,1)=-c(z);
    rot(i,2)=round(xw_cha);
    toc;
end
er=theta_z(1,1:count2)'-rot(:,1);
figure(1);
plot(er);
xlabel('投影角度');
ylabel('摆角误差');
title('摆角对比');
figure(2);
% plot(rot(:,2));
m_xx=zeros(nViews,1);
for i=1:nViews
    if(rot(i,2)>0)
         m_xx(i,1)=max(rot(:,2))-rot(i,2);
    else
         m_xx(i,1)=-(max(rot(:,2))-abs(rot(i,2)));
    end
end
hold on;
plot(m_x(1,1:count2)');
hold on;
plot(m_xx);
hold on;
plot(m_xx-m_x');
xlabel('投影角度');
ylabel('相位');
title('端跳对比');
legend('端跳','相位和端跳的差','端跳误差');
figure(3);
m_xx=rot(:,2)-(max(rot(:,2))+min(rot(:,2)))/2-0.5;
figure;
plot(m_xx+m_x');
xlabel('投影角度');
title('端跳误差');


%% 质心运动轨迹找m_y(径跳)
nViews=180;
time=0:179;
x1=10;y1=10;
[x,y]=matem_y(p_z,theta_z,m_x',nViews,x1,y1);
% 用拟合曲线的方式
weight=zeros(nViews,2);
weight(:,1)=x';
weight(:,2)=y';
[Iweight1,Param_x1] = Fit_by_LLS(weight,theta);
figure
plot(theta,x,'*');
hold on;
plot(Iweight(:,1));
title('质心运动轨迹');
legend('质心位置','拟合函数');
m_yyy=-round(x'-Iweight(:,1));
cham_y=zeros(nViews,1);
cham_y=m_y'-m_yyy;
figure;
plot(cham_y);
xlabel('投影角度');
title('径跳误差');
%% 

end

  