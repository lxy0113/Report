function [zf,xw]=mate(I,k)
[N,M]=size(I);
t=N/2;
c=-1:0.1:1;
xw=zeros(21,1);
zf=zeros(21,1);
for i=1:21
    o=Rotate1(I,k,c(i));
    [ab,ang]=furo(o');
    zf(i,1)=ab(t);
    xw(i,1)=ang(t)*N/(2*pi);
end
end