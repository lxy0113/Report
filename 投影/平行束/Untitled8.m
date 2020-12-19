N=512;
num=10000;
%% ����ͼ��
image=zeros(N,N);
off_theta=5;
off_h=5;
for i=1:N
    for j=1:N
        if((i-120)^2+(j-50)^2<=400)
            image(i,j)=1;
        end
    end
end
% figure(1)
% imshow(image,[]);
image = double(image)/255;
[M,N]=size(image);%(M�У�N��)
%% ��������
label=zeros(num,2);
nViews=720;%��ת�Ƕ�
angle=360/nViews;%ÿ����ת�ĽǶ���
nBins=N; %̽�����ĸ���
num_angle=8;
theta=0:angle:360-angle;
[Ix,Iy]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);%ͼ������
dis=(N-1)/(nBins-1); %����֮��ļ��
%% ��Ͷ����
tic;
for time=1:num
    a1 = randperm(2,1);
    b1 = randperm(2,1);
    th = power(-1,a1)*randperm(500,1)/100;
    theta1=th*pi/180;
    h=power(-1,b1)*randperm(5000,1)/1000;
% [Rx,Ry]=meshgrid(-N/2+0.5:dis:N/2-0.5,-M/2+0.5:M/2-0.5);%�����������
    [Rx,Ry]=meshgrid((-N/2+0.5+h)*cos(theta1):dis*cos(theta1):(N/2-0.5+h)*cos(theta1),-M/2+0.5:M/2-0.5);

    u=zeros(nViews,nBins);
    for i=1:nViews
        u(i,:)=dis*projection(image,Ix,Iy,Rx,Ry,theta(i));
    end
    for i=1:nViews
        j=1:nBins;
        a(1,i)=sum( u(i,:).*j)/sum(u(i,:));
    end
    for i=1:num_angle
        u1(time,i)=a(1,1+(i-1)*90);
    end
    label(time,1)=h;
    label(time,2)=th;
    fid = fopen(['train\',num2str(time),'.dat'],'w');
    fwrite(fid,u1(time,:),'float32');
    fclose(fid);
end
toc;
%% ���ݱ���
tic;
scrvar=sprintf('label');
dstnme=sprintf('train_label.csv');
eval(['save ',dstnme,'label ',scrvar,' -ascii']);
toc;
% figure;
% imshow(u,[]);
% figure;
% plot(a);
