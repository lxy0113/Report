function [zf,xw]=mate(I,k,c)
[N,M]=size(I);
t=N/2;
[c2,count]=size(c);
xw=zeros(count,1);
zf=zeros(count,1);
for i=1:count
    o=Rotate1(I,k,c(i));
    [ab,ang]=furo(o');
    zf(i,1)=ab(t);
    xw(i,1)=ang(t)*N/(2*pi);
end
end