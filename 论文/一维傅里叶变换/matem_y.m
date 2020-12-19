%% 质心运动轨迹
function [x,y]=matem_y(Proj,rot,jz,nViews,x1,y1)
[N,M,K]=size(Proj);
x=zeros(1,nViews);
y=zeros(1,nViews);
for i=1:180
    o=Proj(:,:,i);
    %按照旋转角度，逆向旋转回去
    o1=Rotate1(o,12,-rot(1,i));
    %按照跳动幅度，逆向跳动回去
    px=zeros(N+2*x1+10,N+2*y1+10);%扩充矩阵
    px(x1+1+5:N+x1+5,y1+1+5:N+y1+5)=o1;
    o2=px(x1+1+jz(i)+5:N+jz(i)+x1+5,y1+1+5:N+y1+5);
    [a,b]=Center(o2);
    x(i)=a;
    y(i)=b;
end
end