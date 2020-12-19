function [ ProjData_cor,Err_cor ] = CorrectProj01( ProjData_err,Method )
%CorrectProj01 对投影数据进行校正
%   ProjData_err 带误差的投影数据
%   Method 方法选择


Isize=size(ProjData_err,1);

%% 找出标准投影
alpha1=1;
alpha2=90;
RoX=ProjData_err(:,:,alpha1);
RoY=ProjData_err(:,:,alpha2);
seekangle=-2:0.1:2;% 角度遍历范围
[Err,thetaX,thetaY]=GetRotateError(RoX,RoY,seekangle,Method);

% debug
if 1
    figure(1),imshow(Err,[0,0.001],'InitialMagnification','fit')
    axis on
    
end
%



Proj_stdX=imrotate(RoX,thetaX,'crop','bilinear');

%% 对投影进行角度校正

[ProjData_cor1,Correct_angle]=CorrectProjAngle(Proj_stdX,ProjData_err,seekangle,Method);

creatpath='F:\Work2020\GeometryErrorCorrection\Data\data 1.2\CreatData\';
OriErr=xlsread([creatpath,'OriErr.xls']);
figure,plot([Correct_angle' OriErr(:,3) Correct_angle'-OriErr(:,3)])


%% 对投影进行竖直位移校正

%根据两张图的误差修正第一张图的竖直平移量
Proj_stdY=imrotate(RoY,thetaY,'crop','bilinear');
sP_X=sum(Proj_stdX,2);
sP_Y=sum(Proj_stdY,2);
fsP_X=fftshift(fft(fftshift(sP_X)));
fsP_Y=fftshift(fft(fftshift(sP_Y)));
Err02=angle(fsP_X./fsP_Y)*Isize/(2*pi);
m_y2=round(Err02(end/2)/2);
Proj_stdX=ImgTrans3D(Proj_stdX,0,m_y2);

[ProjData_cor2,M_x,M_y ] = CorrectProjMove( Proj_stdX,ProjData_cor1,2 );
ProjData_cor=ProjData_cor2;

Err_cor=[M_x M_y Correct_angle];


end

