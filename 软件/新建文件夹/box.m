
%% ����0��90���������λ
a=p(:,:,1);
b=p(:,:,2);
for k=1:20
bb=Rotate1(b,k,-1);
[ab0,ang0]=furo(b');
[ab1,ang1]=furo(bb');
v(k)=ab0(63)-ab1(63);
x(k)=ang0(63)*128/(2*pi)-ang1(63)*128/(2*pi);
end
figure(1)
plot(v);
title('���ŷ��������仯�������');
figure(2)
plot(x);
title('���ŷ��������仯����λ��');
% 
% k=12;
% aa=Rotate1(a,k,-1);
% bb=Rotate1(b,k,-0.3);
% [ab01,ang01]=furo(aa');
% [ab11,ang11]=furo(bb');
% v1=[ab01(63),ab11(63)];
% x1=[ang01(63)*128/(2*pi),ang11(63)*128/(2*pi)];
% figure(3)
% plot(e,v1,'*');
% title('0���90����Ͷ������ת1��0.3��֮������ı仯');
% figure(4)
% plot(e,x1,'*');
% title('0���90����Ͷ������ת1��0.3��֮����λ�ı仯');

%% ƥ��(�һ�׼)
% a=p_z(:,:,1);
% b=p_z(:,:,6);
% [zf1,xw1]=mate(a,1);
% [zf2,xw2]=mate(b,1);
% tx=zeros(10,1);
% for i=1:10
%     a=p_xy(:,:,i);
%     [zf1,xw1]=mate(a,1);
%     tx(i,1)=xw1(11);
% end
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
%% �����нǶ��µ�m_x��theta_z
o=p_z(:,:,1);
[t,y]=mate(o,12);%k=12,��ͼ���������
rot=zeros(180,2);
rot(1,1)=0.7;%��һ�б�ʾ��ת�ĽǶ�
rot(1,2)=0;%�ڶ��б�ʾ��0��Ķ�����
r=-1:0.1:1;
for i=2:180
    tic;
    [t1,y1]=mate(p_z(:,:,i),12);
%   
%         imshow(p_z(:,:,i),[]);
%         pause(0.2);
    %����С�����
    c1=100;
    z=1;
    for j=1:21
        c=abs(t(4)-t1(j));
        if(c<c1)
            c1=c;
            z=j;
        end
    end
    xw_cha=y(4)-y1(z);
    rot(i,1)=-r(z);
    rot(i,2)=round(xw_cha);
    toc;
end
% %��������m_x��theta_z;
% % scrvar=sprintf('rot');
% % dstnme=sprintf('rot.csv');
% % eval(['save ',dstnme,'rot ',scrvar,' -ascii']);
% % �������ֵ
% 
p=theta_z';
mx=m_x';
figure(1);
cham_x=mx(:,1)-rot(:,2);
plot(cham_x-1);
title('�������');
figure(2);
chatheta_z=p(:,1)-rot(:,1);
plot(chatheta_z);
title('�ڶ����');
% figure(1)
% plot(cham_x);
% title('m_x(����)�����');
% figure(2)
% plot(chatheta_z);
% title('theta_z(�ڽ�)�����')

% scrvar=sprintf('label');
% dstnme=sprintf('rot.csv');
% eval(['save ',dstnme,'rot ',scrvar,' -ascii']);

%% �����˶��켣��m_y(����)
% nbins=N;
% nviews=180;
% time=1:180;
% [x,y]=matem_y(p_z,rot,nbins,nviews);
% figure
% plot(time,x,'*');
% title('�����˶��켣');

