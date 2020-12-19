function [ ReBdImg ] = iRadon2D( ProjImg,theta,Isize,Method )
%iRadon2D ��άRadon��ͶӰ�ؽ�
%   �˴���ʾ��ϸ˵��

if nargin==2
    Isize=size(ProjImg,1);
    Method=1.0;
end

if nargin==3
    Method=1.0;
end

%% FBP�㷨
if Method==1.1
    Psize=size(ProjImg,1);
    Iangle=length(theta);
    enlarge_sampling=1;
    APsize=floor(2^(nextpow2(Psize)+enlarge_sampling));
    Augsize=floor((APsize-Psize)/2);
    if Augsize>0
        AugProj=[zeros(Augsize,Iangle);ProjImg;zeros(Augsize,Iangle)];
    else
        AugProj=ProjImg;
    end
    
    %FFT
    fP0=fftshift(fft(fftshift(AugProj)));
    
    %�˲�
    fP0_filt=fP0*0;
    abs_filter=-APsize/2:APsize/2-1;
    abs_filter=abs(abs_filter)/APsize*pi^2;
    %     filter(end/2+1)=filter(end/2);
    window_type=1;
    switch window_type
        case 1  % ���δ�
            window_arr=ones(1,APsize);
        case 2  % Shepp-Logan��
            window_arr = abs(sinc(abs_filter));
        case 3  % Hamming��
            c=0.54;
            window_arr = c - (1-c)*cos(2*pi*[-APsize/2:APsize/2-1]/APsize);
        otherwise %���˲�
            abs_filter=1;
    end
    
    window_range=zeros(1,APsize);
    window_range(Augsize+1:Augsize+Psize)=1;
%     window_range=window_range*0+1;

    window_arr=window_arr.*window_range;
    abs_filter=abs_filter.*window_arr;
    
    for i=1:Iangle
        fP0_filt(:,i)=fP0(:,i).*abs_filter';
    end
    
    %iFFT
    P0_filt=fftshift(ifft(fftshift(fP0_filt)));
    if Augsize>0
        P0_filt=P0_filt((Augsize+1):(Augsize+Psize),:);
    else
        % do nothing
    end
    P0_filt=real(P0_filt);
    
    
    %��ͶӰ
    ReBdImg=zeros(Isize);
    dDetect=1;
    Plabel=(-Psize/2+0.5:Psize/2-0.5)*dDetect;
    dRotat=dDetect*Isize/Psize;
    Ilabel=(-Isize/2+0.5:Isize/2-0.5)/dRotat;
    [Xid0,Yid0]=meshgrid(Ilabel);
    for i=1:Iangle
        rad=theta(i);
        Proj_i=P0_filt(:,i);
        Rebd_1=interp1(Plabel,Proj_i,Ilabel,'linear',0);
        Rebd_2=repmat(Rebd_1/Isize,Isize,1);
        Xid=Xid0*cosd(rad)-Yid0*sind(rad);
        Yid=Xid0*sind(rad)+Yid0*cosd(rad);
        Rebd_3=interp2(Xid0,Yid0,Rebd_2,Xid,Yid,'linear',0);
        ReBdImg=ReBdImg+Rebd_3;
%         figure(1)
%         imshow(ReBdImg,[])
%         pause(0.01)
        
        
    end
%     ReBdImg=ReBdImg*pi^2;
    
    %����Ұ���ֵΪ0
    [X,Y]=meshgrid(1:Isize);
    cid=(((X-Isize/2).^2+(Y-Isize/2).^2)>(Isize/2)^2);
    ReBdImg(cid)=0;
    
end

if Method==1.0
%     Psize=size(ProjImg,1);
%     ProjImg=(ProjImg(1:Psize-1,:)+ProjImg(2:Psize,:))/2;
    ReBdImg=iradon(ProjImg,theta,'linear','Ram-Lak',1,Isize);
end

%% ART�㷨
if Method==2
    %
    %ͼ���ͶӰ���̷�����Ϊ��R*X=P
    %
    %RΪ������ͼ������Ľ��߳�
    %XΪͼ�����
    %PΪͶӰ
    %
    
    iterN=1;                                                                %��������
    RN=Isize;                                                               %�ؽ�ͼ���С:pix
    ReBdImg=zeros(RN);                      
    AN=length(theta);                                                       %ͶӰ�Ƕ�����
    rand_id=randperm(AN);                                                   %����Ǵ���
    theta_rand=theta(rand_id);                                              %����Ƕȣ���
    
    dRotate=1;                                                              %ת̨����ͼ��ȡ�������mm
    rlabel=(-(RN-1)/2:(RN-1)/2)*dRotate;                                    
    [X0,Y0]=meshgrid(rlabel);                                               %ת̨����ͼ����������
    NegBoundidex=X0.^2+Y0.^2>(RN/2*dRotate)^2;                              %ͼ��������ת̨���������������

    DN=size(ProjImg,1);                                                     %̽������Ԫ����������������
    dDetect=DN/RN*dRotate;                                                  %̽������Ԫ�����mm
    dlabel=(-(DN-1)/2:(DN-1)/2)*dDetect;                                    
    [RayX0,RayY0]=meshgrid(dlabel);                                         %������������
    
    for iter=1:iterN
        for i=1:AN
            theta_i=theta_rand(i);
            RayX=RayX0*cosd(theta_i)-RayY0*sind(theta_i);
            RayY=RayX0*sind(theta_i)+RayY0*cosd(theta_i);
            Img_Ray=interp2(X0,Y0,ReBdImg,RayX,RayY,'linear',0);
            ProjReBd=sum(Img_Ray,2)*dDetect;                                %����R*X
            ProjErr=(ProjImg(:,rand_id(i))-ProjReBd)/(RN*dRotate);          %����(P-R*X)/|R|
            
            BackprojErr=repmat(ProjErr,1,RN);
            X=X0*cosd(theta_i)+Y0*sind(theta_i);
            Y=-X0*sind(theta_i)+Y0*cosd(theta_i);
            BackprojErr2=interp2(RayX0,RayY0,BackprojErr,X,Y,'linear',0);
            ReBdImg=ReBdImg+BackprojErr2;                                   %X=X+Err
        
        end
        ReBdImg(NegBoundidex)=0;
    end
    ReBdImg=ReBdImg';
end

