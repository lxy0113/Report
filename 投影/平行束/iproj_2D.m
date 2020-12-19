function[I]=iproj_2D(proj,N,nViews,nBins,theta,i,dis,k_final)
M=N;
for j=1:nViews
    for z=1:N
        p(j,z)=proj(i,j,z);
    end
end  
[Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);%图像坐标
[Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);%采样点的坐标
I=zeros(M,N);
for iter=1:k_final
    for i=1:nViews
        error=(p(i,:)-dis*projection(I,Ix,Iy,Rx,Ry,theta(i)))/N;
        XI=Ix.*cosd(theta(i))-Iy.*sind(theta(i));
        I=I+interp1(Rx(1,:),error,XI,'linear',0);%把误差平均的加到图片上
    end   
    I(I<0)=0;
    I(I>1)=1;                                                    
end