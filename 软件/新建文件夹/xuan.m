%%%%%%��ͼ�������ת����
% clc;clear;close;
naturalimag=p_z(:,:,1);%jpegtu.jpg?
figure(1);
imshow(naturalimag);
title('ԭͼ��');
[m,n,r]=size(naturalimag);%%%%mΪ������x����nΪ������y����,rΪά��??
dag=10*pi/180;%��ת�ĽǶ�?
backgroundgray=0;%%%%��������ֵ�ĻҶ�ֵ?
a=cos(dag);
b=sin(dag);
processedxmin=round(a-n*b);
processedxmax=round(m*a-b);
processedymin=round(a+b);
processedymax=round(m*b+n*a);
nr=processedxmax-processedxmin+1;%%%%������x?
nc=processedymax-processedymin+1;%%%%%����,y??
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
title('��ת��δ��ֵ�����ͼ��');
%%%%��ͼ���пո�����в�ֵ?
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