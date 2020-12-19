function []=Amp_phase(ProjImg)
[N,M,nViews]=size(ProjImg);
v=zeros(nViews,1);
x=zeros(nViews,1);
for i=1:nViews
    [ab,ang]=furo((ProjImg(:,:,i))');
    v(i)=ab(N/2);
    x(i)=ang(N/2)*N/(2*pi);
end
figure
plot(v);
xlabel('投影角度');
ylabel('振幅');
title('振幅随投影角度变化');
figure
plot(x);
xlabel('投影角度');
ylabel('相位');
title('相位随投影角度变化');
end