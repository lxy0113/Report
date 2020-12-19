function [ output_proj,Mx_cor ] = ProjCor_x( input_proj,theta,itern,Method )
%ProjCor_x ͨ����������ͶӰˮƽ����
%   input_proj ����Ķ�άͶӰ��Ĭ��̽����������תֱ̨��һ�£�
%   theta ��Ӧ��ͶӰ�Ƕ�
%   itern ��������
%   Method ��������
%   1������ǰ�����ڽ�ͶӰ��ͶӰ��ƥ�䣬Ȼ�������ͶӰ�Ŀռ���ƥ��
%   2������ǰ�����ڽ�ͶӰ��ͶӰ��ƥ�䣬ֱ�ӽ�����ͶӰ�Ŀռ���ƥ��
%   3(Ĭ��)������ǰ�����ڽ�ͶӰ��ͶӰ��ƥ�䣬Ȼ�������ͶӰ�ĸ���Ҷ��ƥ��
%   4������ǰ�����ڽ�ͶӰ��ͶӰ��ƥ�䣬ֱ�ӽ�����ͶӰ�ĸ���Ҷ��ƥ��

if nargin==3
    Method=3;
end

if nargin==2
    itern=5;
    Method=3;
end

Isize=size(input_proj,1);
Iangle=length(theta);
Mx_cor=zeros(1,Iangle);
proj0=input_proj;

%����ƥ��

for iter=1:itern
    
    %1.���ڽǶ�ͶӰƥ��
    if Method==1||Method==3
        [input_proj,Mx_cor_t]=MatchProj1D(input_proj);
        Mx_cor=Mx_cor+Mx_cor_t;
    end

    ReBd1=iRadon2D(input_proj,theta);
    ReBd1(ReBd1<0)=0;
    P1=Radon2D(ReBd1,theta);
    
    % debug
    if sin(iter*pi/180*30)>1
        figure(1)
        imshow(ReBd1,[])
        xlabel(['iter=',num2str(iter)])
        figure(2)
        imshow([input_proj P1],[])
        pause(0.1)
    end
    %
    for i=1:Iangle
        P_ref=P1(:,i);
        P_ref=P_ref';
        Perr0=input_proj(:,i);
        Perr0=Perr0';
        
        if Method==1||Method==2
            seek_Mx=-30:30;
            Err=zeros(1,length(seek_Mx));
            for j=1:length(seek_Mx)
                Perr=ImgTrans1D(Perr0,seek_Mx(j));
                Err(j)=mean((P_ref-Perr).^2);
            end
            sMx=seek_Mx(Err==min(Err));
            sMx=round(sMx);
        end
        
        if Method==3||Method==4
            fP_ref=fftshift(fft(fftshift(P_ref)));
            fPerr0=fftshift(fft(fftshift(Perr0)));
            sMx=angle(fP_ref./fPerr0)*Isize/(2*pi);
            sMx=round(sMx(end/2));
        end
        
        Perr=ImgTrans1D(Perr0,sMx);
        Mx_cor(i)=Mx_cor(i)-sMx;
        input_proj(:,i)=Perr';
    end
    
    
    % debug3
    if 0
        figure(3),plot(theta,MX,theta,Mx_cor)
        legend('MX_{ori}','MX_{cor}')
        xlabel(['iter = ',num2str(iter)])
        pause(0.5)
    end
    %
    
    
end
output_proj=input_proj;

% debug2
if 1
    rebd0=iRadon2D(proj0,theta);
    rebd_out=iRadon2D(output_proj,theta);
    
    figure(5)
    imshow([proj0 output_proj],[])
    title(['1.ˮƽУ��ǰ ','2.������ͶӰУ��'])
    
    figure(6)
    imshow([rebd0 rebd_out],[])
    title(['1.ˮƽУ��ǰ ','2.������ͶӰУ��'])
end
%




end

