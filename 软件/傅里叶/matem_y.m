%% �����˶��켣
function [x,y]=matem_y(Proj,rot,jz,nbins,nviews)
[N,M,K]=size(Proj);
x=zeros(1,nviews);
y=zeros(1,nviews);
for i=1:nviews
    o=Proj(:,:,i);
    %������ת�Ƕȣ�������ת��ȥ
    o1=Rotate1(o,12,-rot(i,1));
    %�����������ȣ�����������ȥ
    px=zeros(nbins+20,N+20);%�������
    px(11:nbins+10,11:N+10)=o1;
    o2=px(11+jz(i,3):nbins+jz(i,3)+10,11:N+10);
    [a,b]=Center(o2);
    x(i)=a;
    y(i)=b;
end