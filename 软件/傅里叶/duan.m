mm=m_x';
rot(1,2)=round(rot(1,2));
c=max(abs(rot(:,2)));
%sign用来判断一个数的符号
jz=zeros(180,3);
jz(:,1)=sign(rot(:,2));
jz(:,2)=rot(:,2);
for i=1:180
    if(jz(i,1)>0)
        jz(i,3)=c-jz(i,2);
    else
        jz(i,3)=-(c-abs(jz(i,2)));
    end  
end
cha_x=jz(:,3)-mm(:,1);
figure
plot(cha_x);
title('端跳误差');