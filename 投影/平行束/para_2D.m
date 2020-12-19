function[I]=para_2D(image1,nViews,nBins,N,i)
M=N;
for z=1:N
    for j=1:N
        image(z,j)=image1(i,z,j);
    end
end
angle=180/nViews;%ÿ����ת�ĽǶ���
dis=(N-1)/(nBins-1); %����֮��ļ��
[Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);%ͼ������
[Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);%�����������
theta=0:angle:180-angle;
proj=zeros(nViews,nBins);
for i=1:nViews
    proj(i,:)=dis*projection(image,Ix,Iy,Rx,Ry,theta(i));
end
p=proj;
I=zeros(M,N);
k_final=20;
for iter=1:k_final
    for i=1:nViews
        error=(p(i,:)-dis*projection(I,Ix,Iy,Rx,Ry,theta(i)))/N;
        XI=Ix.*cosd(theta(i))-Iy.*sind(theta(i));
        I=I+interp1(Rx(1,:),error,XI,'linear',0);%�����ƽ���ļӵ�ͼƬ��
    end   
    I(I<0)=0;
    I(I>1)=1;                                                    
end
% I1=I-image;
% imshow(I,[]);
end