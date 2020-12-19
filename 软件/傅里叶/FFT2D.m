function [zw,xw]=FFT2D(I)
[N,M]=size(I);
f1=fftshift(fft2(I'));
f2=f1(N/2+1,:);
absf2=abs(f2);
angf2=angle(f2);
zw=absf2(N/2);
xw=angf2(N/2);
end