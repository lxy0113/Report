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
xlabel('ͶӰ�Ƕ�');
ylabel('���');
title('�����ͶӰ�Ƕȱ仯');
figure
plot(x);
xlabel('ͶӰ�Ƕ�');
ylabel('��λ');
title('��λ��ͶӰ�Ƕȱ仯');
end