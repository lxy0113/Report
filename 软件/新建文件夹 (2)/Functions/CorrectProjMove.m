function [ProjData_cor,M_x,M_y ] = CorrectProjMove( ProjData_std,ProjData_err,Method )
%CorrectProjAngle 通过一个投影角度下标准的投影，校正一系列投影角度下带误差的投影
%   ProjData_std 标准的投影
%   ProjData_err 带误差的一系列投影
%   ProjData_cor 校正的投影
%   seekangle 搜索角度
%   Method 方法：1.输入的ProjData_std为所有角度下标准的投影，直接进行2D傅立叶变换校正（默认）
%               2.输入的ProjData_std为单个角度下标准的投影，进行频域二次投影搜索校正Y方向的误差
%               3.频域中心切片定理方式校正

if nargin==2
    Method=1;
end
[Isize,~,Iangle]=size(ProjData_err);
% ProjData_cor=ProjData_err;

M_x=zeros(1,Iangle);
M_y=zeros(1,Iangle);

if Method==1
    for i=1:Iangle
        Pstd=ProjData_std(:,:,i);
        Perr=ProjData_err(:,:,i);
        fPstd=fft2(fftshift(Pstd));
        fPerr=fft2(fftshift(Perr));
        Err01=angle(fPstd./fPerr)*Isize/(2*pi);
        
        M_x(i)=Err01(end/2+1,end/2);
        M_y(i)=Err01(end/2,end/2+1);

    end   
end

if Method==2
    if length(size(ProjData_std))==3
       disp('输入的标准投影数量过多，只选取第一张标准投影！') 
       ProjData_std=ProjData_std(:,:,1);
    end
    sP_std=sum(ProjData_std,2);
    fsP_std=fftshift(fft(fftshift(sP_std)));
    for i=1:Iangle
        P_err=ProjData_err(:,:,i);
        sP_err=sum(P_err,2);
        fsP_err=fftshift(fft(fftshift(sP_err)));
        Err02=angle(fsP_std./fsP_err)*Isize/(2*pi);
        M_y(i)=round(Err02(end/2));
    end   

end

% 通过相位校正位移时，可能有部分数据差别较大（相差一个pi/2相位），故需要修正M_x，M_y
M_x(M_x>Isize/3)=M_x(M_x>Isize/3)-Isize/2;
M_x(M_x<-Isize/3)=M_x(M_x<-Isize/3)+Isize/2;
M_y(M_y>Isize/3)=M_y(M_y>Isize/3)-Isize/2;
M_y(M_y<-Isize/3)=M_y(M_y<-Isize/3)+Isize/2;


ProjData_cor=ImgTrans3D(ProjData_err,M_x,-M_y);




end

