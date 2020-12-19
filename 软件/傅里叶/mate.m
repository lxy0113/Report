function [zf,xw]=mate(I,k)
[N,M]=size(I);
c=-2:0.1:2;
[m,count]=size(c);
xw=zeros(count,1);
zf=zeros(count,1);
for i=1:count
    o=Rotate1(I,k,c(i));
    [ab,ang]=FFT2D(o);
    zf(i,1)=ab;
    xw(i,1)=ang*512/(2*pi);
end
end