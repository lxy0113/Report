function [ output_proj,Mx_cor ] = ProjCor_x( input_proj,theta,itern,Method )
%ProjCor_x 通过迭代修正投影水平抖动
%   input_proj 输入的二维投影（默认探测器长度与转台直径一致）
%   theta 对应的投影角度
%   itern 迭代次数
%   Method 迭代方法
%   1：迭代前加入邻近投影角投影的匹配，然后进行重投影的空间域匹配
%   2：迭代前不加邻近投影角投影的匹配，直接进行重投影的空间域匹配
%   3(默认)：迭代前加入邻近投影角投影的匹配，然后进行重投影的傅立叶域匹配
%   4：迭代前不加邻近投影角投影的匹配，直接进行重投影的傅立叶域匹配

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

%迭代匹配

for iter=1:itern
    
    %1.相邻角度投影匹配
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
    title(['1.水平校正前 ','2.迭代重投影校正'])
    
    figure(6)
    imshow([rebd0 rebd_out],[])
    title(['1.水平校正前 ','2.迭代重投影校正'])
end
%




end

