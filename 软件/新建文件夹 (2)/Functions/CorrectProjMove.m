function [ProjData_cor,M_x,M_y ] = CorrectProjMove( ProjData_std,ProjData_err,Method )
%CorrectProjAngle ͨ��һ��ͶӰ�Ƕ��±�׼��ͶӰ��У��һϵ��ͶӰ�Ƕ��´�����ͶӰ
%   ProjData_std ��׼��ͶӰ
%   ProjData_err ������һϵ��ͶӰ
%   ProjData_cor У����ͶӰ
%   seekangle �����Ƕ�
%   Method ������1.�����ProjData_stdΪ���нǶ��±�׼��ͶӰ��ֱ�ӽ���2D����Ҷ�任У����Ĭ�ϣ�
%               2.�����ProjData_stdΪ�����Ƕ��±�׼��ͶӰ������Ƶ�����ͶӰ����У��Y��������
%               3.Ƶ��������Ƭ����ʽУ��

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
       disp('����ı�׼ͶӰ�������ֻ࣬ѡȡ��һ�ű�׼ͶӰ��') 
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

% ͨ����λУ��λ��ʱ�������в������ݲ��ϴ����һ��pi/2��λ��������Ҫ����M_x��M_y
M_x(M_x>Isize/3)=M_x(M_x>Isize/3)-Isize/2;
M_x(M_x<-Isize/3)=M_x(M_x<-Isize/3)+Isize/2;
M_y(M_y>Isize/3)=M_y(M_y>Isize/3)-Isize/2;
M_y(M_y<-Isize/3)=M_y(M_y<-Isize/3)+Isize/2;


ProjData_cor=ImgTrans3D(ProjData_err,M_x,-M_y);




end

