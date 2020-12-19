function[realfX,imagfX,absfX,anglefX]=furo(y)
% oo=pro_2D(y,1,1,1,256);
fX=fftshift(fft(y));
realfX=real(fX);
imagfX=imag(fX);
absfX=abs(fX);
anglefX=angle(fX);
end