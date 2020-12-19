clc,clear
close all;
dataid=1.2;
datapath=['F:\Work2020\GeometryErrorCorrection\Data\data ',num2str(dataid),'\'];
addpath(datapath);
addpath('Functions\');
%% ���ݶ�ȡ������趨

if dataid==1.2
    datapath_input=datapath;
    Isize=512;
    theta=1:180;
    Iangle=length(theta);
    
    proj_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Iangle),'.raw'];
    orig_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Isize),'.raw'];
    ProjImg=ReadFileToImg([datapath_input,'ProjImg',proj_lastname],Isize,Isize,'float32');

end

if dataid==2.8
    datapath_input='E:\���ڽ�չ\���β���У��\data\process\data2.8\';
    Isize=1024;
    theta=0:0.5:180;
    Iangle=length(theta);
    
    proj_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Iangle),'.raw'];
    orig_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Isize),'.raw'];
    ProjImg=ReadFileToImg([datapath_input,'ProjImg',proj_lastname],Isize,Isize,'float32');
    
    %     ReBdImg=iRadon3D(ProjImg,theta);
    %     WriteImgToFile([datapath_input,'ReBdImg',orig_lastname],ReBdImg,'float32');
    %     clc,clear;
end

if dataid==2.9
    datapath_input='E:\���ڽ�չ\���β���У��\data\process\data2.9\';
    Isize=1024;
    theta=-90:89;
    Iangle=length(theta);
    
    proj_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Iangle),'.raw'];
    orig_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Isize),'.raw'];
    ProjImg=ReadFileToImg([datapath_input,'ProjImg',proj_lastname],Isize,Isize,'float32');
    
    %     ReBdImg=iRadon3D(ProjImg,theta);
    %     WriteImgToFile([datapath_input,'ReBdImg',orig_lastname],ReBdImg,'float32');
    %     clc,clear;
end


%% Ƶ��У������
if 1
    
    [ ProjImg_cor ] = CorrectProj01( ProjImg,2 );
    WriteImgToFile([datapath_input,'ProjImg_cor',proj_lastname],ProjImg_cor,'float32');
    
end

%% ˮƽ�����У��
if 0

ProjImg_cor=ReadFileToImg([datapath_input,'ProjImg_cor',proj_lastname],Isize,Isize,'float32');
tomo_Y=280;
ProjImg0=ProjImg_cor(tomo_Y,:,:);
ProjImg0=reshape(ProjImg0,Isize,Iangle);

itern=8;
tic
ProjImg1=ProjCor_x(ProjImg0,theta,itern,3);
toc

end

%% ����У��ͶӰƥ�����
if 1
% ��������
Isize=512;
theta=1:1:180;
Iangle=length(theta);
% Img=phantom(Isize);
Img=DrawSomething(Isize,6);
% Img=zeros(Isize);Img(end/2+64,end/2)=1;
ProjImgO=Radon2D(Img,theta);
ProjImg=ProjImgO;

MX=randn(1,Iangle)*4+20;
% MX=rand(1,Iangle)*20-10+20;
MX=round(MX);
for i=1:Iangle
    tempP=ProjImgO(:,i);
    tempP=tempP';
    tempP=ImgTrans1D(tempP,MX(i));
    tempP=tempP';
    ProjImg(:,i)=tempP;
end
save RandMx.mat MX
% ���Ӳ�������
I0=1e5;
PhoImg=poissrnd(I0*exp(-ProjImg/max(ProjImg(:))));
ProjImg=-log(PhoImg/I0)*max(ProjImg(:));

%����1�� ��������
% itern=64;
% [ProjImg_cor,MX_cor]=ProjCor_x(ProjImg,theta,itern,3);


%����2�� �������Ĺ켣���
Weight=GetWeight(ProjImg');
[Iweight,Parm_x]=Fit_by_LLS(Weight,theta);
MX_cor=Iweight-Weight;
B=Parm_x(3);
MX_cor=MX_cor+(Isize/2-B);
MX_cor=round(MX_cor);
ProjImg_cor=ProjImg*0;
for i=1:Iangle
    projt=ImgTrans1D(ProjImg(:,i)',MX_cor(i));
    ProjImg_cor(:,i)=projt';
end


%�鿴����1���Խ��
if 0
    rebd=iRadon2D(ProjImg,theta);
    rebd_out=iRadon2D(ProjImg_cor,theta);
    figure(5)
    imshow([ProjImg ProjImg_cor],[])
    xlabel(['1.ˮƽУ��ǰ ','2.������ͶӰУ��'])
    figure(6)
    imshow([rebd rebd_out],[])
    xlabel(['1.ˮƽУ��ǰ ','2.������ͶӰУ��'])
    figure(7)
    plot(theta,MX,theta,MX_cor)
    legend('MX_{ori}','MX_{cor}')
end

%�鿴����2���Խ��
if 1 
    rebd=iRadon2D(ProjImg,theta);
    rebd_out=iRadon2D(ProjImg_cor,theta);
    
    figure(5)
    imshow([ProjImg ProjImg_cor],[])
    xlabel(['1.У��ǰ ','2.У����'])
    figure(6)
    imshow([rebd rebd_out],[])
    xlabel(['1.У��ǰ ','2.У����'])
    figure(7)
    plot(theta,MX,theta,-MX_cor)
    legend('MX_{ori}','MX_{cor}')



end





end






