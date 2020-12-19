function[absfX,anglefX]=furo(y)
% oo=radon(y,0);
oo=sum(y);
fX=fftshift(fft(oo));
absfX=abs(fX);
anglefX=angle(fX);
end