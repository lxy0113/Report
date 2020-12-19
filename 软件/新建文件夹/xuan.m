%%%%%%对图像进行旋转处理
% clc;clear;close;
naturalimag=p_z(:,:,1);%jpegtu.jpg?
figure(1);
imshow(naturalimag);
title('原图像');
[m,n,r]=size(naturalimag);%%%%m为行数，x方向，n为列数，y方向,r为维数??
dag=10*pi/180;%旋转的角度?
backgroundgray=0;%%%%用作背景值的灰度值?
a=cos(dag);
b=sin(dag);
processedxmin=round(a-n*b);
processedxmax=round(m*a-b);
processedymin=round(a+b);
processedymax=round(m*b+n*a);
nr=processedxmax-processedxmin+1;%%%%行数，x?
nc=processedymax-processedymin+1;%%%%%列数,y??
processedimag(1:nr,1:nc,1:r)=backgroundgray;
for i=1:m
    for j=1:n
        ii=round(i*a-j*b)-processedxmin+1;
        jj=round(i*b+j*a)-processedymin+1;
        for k=1:r
            processedimag(ii,jj,k)=naturalimag(i,j,k);
        end
    end
end
figure(2);
imshow(processedimag);
title('旋转后未插值处理的图像');
%%%%对图像中空格进行行插值?
for i=1:nr
    for j=2:nc-1
        for k=1:r
             if(processedimag(i,j,k) == backgroundgray && processedimag(i,j-1,k) ~= backgroundgray && processedimag(i,j+1,k) ~= backgroundgray )
                    processedimag(i,j,k) =processedimag(i,j-1,k);
              end
        end
    end
end
figure(3);
imshow(processedimag);
c=processedimag-naturalimag;