%% 质心运动轨迹
function [x,y]=matem_y(Proj,rot,jz,nbins,nviews)
[N,M,K]=size(Proj);
x=zeros(1,nviews);
y=zeros(1,nviews);
for i=1:nviews
    o=Proj(:,:,i);
    %按照旋转角度，逆向旋转回去
    o1=Rotate1(o,12,-rot(i,1));
    %按照跳动幅度，逆向跳动回去
    px=zeros(nbins+20,N+20);%扩充矩阵
    px(11:nbins+10,11:N+10)=o1;
    o2=px(11+jz(i,3):nbins+jz(i,3)+10,11:N+10);
    [a,b]=Center(o2);
    x(i)=a;
    y(i)=b;
end