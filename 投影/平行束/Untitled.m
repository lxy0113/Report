function[I]=para_2D(imagem,nViews,nBins)
% n=256;
% image=phantom(n);
% figure(1)
% imshow(image,[]);
% image = double(image)/255;
[M,N]=size(image);%(M行，N列)
% nViews=130;%旋转角度
angle=180/nViews;%每次旋转的角度数
% nBins=512; %探测器的个数
dis=(N-1)/(nBins-1); %射线之间的间隔
[Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);%图像坐标
[Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);%采样点的坐标
theta=0:angle:180-angle;
proj=zeros(nViews,nBins);
for i=1:nViews
    proj(i,:)=dis*projection(image,Ix,Iy,Rx,Ry,theta(i));
end
% figure;
% imshow(proj,[]);
p=proj;
I=zeros(M,N);
k_final=20;
%a=1:1:nViews;
for iter=1:k_final
    %a=randperm(size(p,1));
    for i=1:nViews
        error=(p(i,:)-dis*projection(I,Ix,Iy,Rx,Ry,theta(i)))/N;
        XI=Ix.*cosd(theta(i))-Iy.*sind(theta(i));
        YI=Ix.*sind(theta(i))+Iy.*cosd(theta(i));
        I=I+interp1(Rx(1,:),error,XI,'linear',0);%把误差平均的加到图片上
    end   
    I(I<0)=0;
    I(I>1)=1;                                                    
end
% I1=I-image;
% imshow(I,[]);
end