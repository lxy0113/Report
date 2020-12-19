
for i=1:6
fly1=fftshift(fft2(p_xy(:,:,i)));
xw=angle(fly1)*512/(2*pi);
cc=xw(256,:);
fly2561(i)=xw(256,257);
end
plot(fly2561);
i=1;