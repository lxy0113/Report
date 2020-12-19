o=im(:,:,1)';
a=im(:,:,45)';
b=im(:,:,45)';
c=im(:,:,90)';

oo=sum(o);
aa=sum(a);

plot(oo);figure
plot(aa);

[m0,index0]=max(oo);
[m1,index1]=max(aa);
[Re0,Im0,ab0,ang0]=furo(oo);
[Re1,Im1,ab1,ang1]=furo(aa);


bb=sum(b);
cc=sum(c);
[Re0,Im0,ab0,ang0]=furo(o);

for i=1:180
    b=p(:,:,i)';
    bb=sum(b);
    [m(i),index(i)]=max(bb);
    [Re2,Im2,ab2,ang2]=furo(b);
    x(i)=ab0(64)-ab2(64);
end
plot(x);
title('振幅随角度变化');
figure
plot(m);

title('最大值大小随角度变化');
figure
plot(index);
title('最大值的位置随角度变化');
    
% [m0,index0]=max(oo);
% [m1,index1]=max(aa);
% [m2,index2]=max(bb);
% [m3,index3]=max(cc);
% dd=(ang2(128)-ang4(128))*256/(2*pi);
% theta=-0.5;
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%图像坐标
% Rx=X.*cosd(theta)-Y.*sind(theta);
% Ry=X.*sind(theta)+Y.*cosd(theta);
% p1=interp2(X,Y,p_z(:,:,1),Rx,Ry,'linear',0);

% 
% 
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%图像坐标
% Rx=X.*cosd(theta)-Y.*sind(theta);
% Ry=X.*sind(theta)+Y.*cosd(theta);
% p05=interp2(X,Y,b',Rx,Ry,'linear',0);
% dd=sum(p05');
% [m4,index4]=max(dd);


% [Re0,Im0,ab0,ang0]=furo(o);
% [Re1,Im1,ab1,ang1]=furo(a);
% [Re2,Im2,ab2,ang2]=furo(b);
% [Re4,Im4,ab4,ang4]=furo(c);
% zf=[ab0(64),ab1(64),ab2(64),ab4(64)];
% xw=[ang0(64),ang1(64),ang2(64),ang4(64)];
% dd=(ang4(64)-ang0(64))*128/(2*pi);


% 
% figure(1);
% imshow(a,[]);
% figure(2);
% imshow(b,[]);
% figure(3);
% imshow(c,[]);
% 
% aa=sum(a);xw
% bb=sum(b);
% cc=sum(c);
% 
% 
% [m1,index1]=max(aa);
% [m2,index2]=max(bb);
% [m3,index3]=max(cc);



