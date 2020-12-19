clc,clear
close all;
dataid=1.2;
datapath=['F:\Work2020\GeometryErrorCorrection\Data\data ',num2str(dataid),'\'];
addpath(datapath);
addpath('Functions\');
%% 数据读取与参数设定

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
    datapath_input='E:\近期进展\几何参数校正\data\process\data2.8\';
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
    datapath_input='E:\近期进展\几何参数校正\data\process\data2.9\';
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


%% 频域校正方法
if 1
    
    [ ProjImg_cor ] = CorrectProj01( ProjImg,2 );
    WriteImgToFile([datapath_input,'ProjImg_cor',proj_lastname],ProjImg_cor,'float32');
    
end

%% 水平方向的校正
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

%% 迭代校正投影匹配测试
if 1
% 构造数据
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
% 增加泊松噪声
I0=1e5;
PhoImg=poissrnd(I0*exp(-ProjImg/max(ProjImg(:))));
ProjImg=-log(PhoImg/I0)*max(ProjImg(:));

%方法1： 迭代修正
% itern=64;
% [ProjImg_cor,MX_cor]=ProjCor_x(ProjImg,theta,itern,3);


%方法2： 层内质心轨迹拟合
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


%查看方法1测试结果
if 0
    rebd=iRadon2D(ProjImg,theta);
    rebd_out=iRadon2D(ProjImg_cor,theta);
    figure(5)
    imshow([ProjImg ProjImg_cor],[])
    xlabel(['1.水平校正前 ','2.迭代重投影校正'])
    figure(6)
    imshow([rebd rebd_out],[])
    xlabel(['1.水平校正前 ','2.迭代重投影校正'])
    figure(7)
    plot(theta,MX,theta,MX_cor)
    legend('MX_{ori}','MX_{cor}')
end

%查看方法2测试结果
if 1 
    rebd=iRadon2D(ProjImg,theta);
    rebd_out=iRadon2D(ProjImg_cor,theta);
    
    figure(5)
    imshow([ProjImg ProjImg_cor],[])
    xlabel(['1.校正前 ','2.校正后'])
    figure(6)
    imshow([rebd rebd_out],[])
    xlabel(['1.校正前 ','2.校正后'])
    figure(7)
    plot(theta,MX,theta,-MX_cor)
    legend('MX_{ori}','MX_{cor}')



end





end






