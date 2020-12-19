%% 质心运动轨迹
function [x,y]=Zx(Proj)
[N,M,K]=size(Proj);
x=zeros(1,180);
y=zeros(1,180);
for i=1:180
    [a,b]=Center(Proj(:,:,i));
    x(i)=a;
    y(i)=b;
end
end