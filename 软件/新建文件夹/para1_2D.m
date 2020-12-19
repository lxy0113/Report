function[ProjImg]=para1_2D(image,N,nBins,nViews,theta)
% dis=(N-1)/(nBins-1); %射线之间的间隔
% [Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%图像坐标
% [Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-N/2+0.5:N/2-0.5);%采样点的坐标
Isize=size(image,1);
ProjImg=radon(image,theta);
Psize=size(ProjImg,1);
ProjImg=ProjImg(floor(Psize/2)-Isize/2+2:floor(Psize/2)+Isize/2+1,:);
ProjImg=ProjImg';
end