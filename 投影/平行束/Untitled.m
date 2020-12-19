function[I]=para_2D(imagem,nViews,nBins)
% n=256;
% image=phantom(n);
% figure(1)
% imshow(image,[]);
% image = double(image)/255;
[M,N]=size(image);%(M�У�N��)
% nViews=130;%��ת�Ƕ�
angle=180/nViews;%ÿ����ת�ĽǶ���
% nBins=512; %̽�����ĸ���
dis=(N-1)/(nBins-1); %����֮��ļ��
[Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);%ͼ������
[Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);%�����������
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
        I=I+interp1(Rx(1,:),error,XI,'linear',0);%�����ƽ���ļӵ�ͼƬ��
    end   
    I(I<0)=0;
    I(I>1)=1;                                                    
end
% I1=I-image;
% imshow(I,[]);
end