function [rot,er,cx]=Test3(p_z)
k=12;
c=-1:0.01:1;
[cm,count]=size(c);
a=p_z(:,:,1);
b=p_z(:,:,57);
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
    rot(i,2)=(xw_cha);
    toc;
end
er=theta_z(1,1:count2)'-rot(:,1);
figure(1);
plot(er);
xlabel('投影角度');
ylabel('摆角误差');
title('摆角对比');
end