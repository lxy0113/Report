function[proj]=para1_2D(image,nViews,nBins,N,theta)
M=N;
dis=(N-1)/(nBins-1); %����֮��ļ��
[Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);%ͼ������
[Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);%�����������
proj=zeros(nViews,nBins);
for z=1:nViews
    proj(z,:)=dis*projection(image,Ix,Iy,Rx,Ry,theta(z));
end
end