o=im1(:,:,1)';
% a=im(:,:,55)';
% b=im(:,:,78)';
% c=im(:,:,90)';
oo=sum(o);
% aa=sum(a);
% 
% plot(oo);
% figure
% plot(aa);
% 
% [m0,index0]=max(oo);
% [m1,index1]=max(aa);
% [Re0,Im0,ab0,ang0]=furo(oo);
% [Re1,Im1,ab1,ang1]=furo(aa);
w = fspecial('gaussian',[5,5],1);
	%replicate:ͼ���Сͨ����ֵ��߽��ֵ����չ
	%symmetric ͼ���Сͨ��������ı߽���о���ӳ����չ
% 	I11 = imfilter(img,w,'replicate');
% 	figure(1);
% 	imshow(img);title('ԭͼ��');
% 	figure(2);
% 	imshow(I11);title('matlab��˹�˲����ͼ��');

% bb=sum(b);
% cc=sum(c);
[Re0,Im0,ab0,ang0]=furo(oo);

for i=1:180
    b=im(:,:,i)';
    b = imfilter(b,w,'replicate');
    bb=sum(b);
    [m(i),index(i)]=max(bb);
    [Re2,Im2,ab2,ang2]=furo(bb);
    x(i)=ab0(128)-ab2(128);
    y(i)=ang0(128)-ang2(128);
end
plot(x);
title('�����Ƕȱ仯');
figure
plot(y);
title('��λ��Ƕȱ仯');
% plot(index);
% title('���ֵ��λ����Ƕȱ仯');
    
% [m0,index0]=max(oo);
% [m1,index1]=max(aa);
% [m2,index2]=max(bb);
% [m3,index3]=max(cc);
% dd=(ang2(128)-ang4(128))*256/(2*pi);
% theta=-0.5;
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%ͼ������
% Rx=X.*cosd(theta)-Y.*sind(theta);
% Ry=X.*sind(theta)+Y.*cosd(theta);
% p1=interp2(X,Y,p_z(:,:,1),Rx,Ry,'linear',0);

% 
% 
% [X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);%ͼ������
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

% 
% for i=1:nviews
%     imshow(im(:,:,i),[]);
%     pause(0.5);
% end
