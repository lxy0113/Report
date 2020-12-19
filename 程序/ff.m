clear
clc
% close all
 
Fs = 1000;
T = 1./Fs;
L =1000;
t = (0:L-1)*T;
 
S0 = 2*sin(2*pi*20*t);    %standard signal without the noise
figure(1);
plot(t,S0);
title('Ô­º¯Êý');
Y1 = fft(S0);                            %fourier transform
figure(2),plot(t,abs(Y1));
 
S = 2*sin(2*pi*20*t)+3*sin(2*pi*50*t);    %standard signal without the noise
figure(3);
plot(t,S);
title('original signal');
Y1 = fft(S);                            %fourier transform
figure(4),plot(t,abs(Y1));
 
S1 = 10+2*sin(2*pi*20*t)+3*sin(2*pi*50*t);    %standard signal without the noise
figure(5);
plot(t,S1);
title('original signal');
Y1 = fft(S1);                            %fourier transform
figure(6),plot(t,abs(Y1));