%% �����˶��켣
function [x,y]=matem_y(Proj,rot,jz,nViews,x1,y1)
[N,M,K]=size(Proj);
x=zeros(1,nViews);
y=zeros(1,nViews);
for i=1:180
    o=Proj(:,:,i);
    %������ת�Ƕȣ�������ת��ȥ
    o1=Rotate1(o,12,-rot(1,i));
    %�����������ȣ�����������ȥ
    px=zeros(N+2*x1+10,N+2*y1+10);%�������
    px(x1+1+5:N+x1+5,y1+1+5:N+y1+5)=o1;
    o2=px(x1+1+jz(i)+5:N+jz(i)+x1+5,y1+1+5:N+y1+5);
    [a,b]=Center(o2);
    x(i)=a;
    y(i)=b;
end
end