function [ ReBdImg ] = iRadon2D( ProjImg,theta,Isize,Method )
%iRadon2D 二维Radon反投影重建
%   此处显示详细说明

if nargin==2
    Isize=size(ProjImg,1);
    Method=1;
end

if nargin==3
    Method=1;
end

Method=2;

%% FBP算法
if Method==1
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
    
    %滤波
    fP0_filt=fP0*0;
    abs_filter=-APsize/2:APsize/2-1;
    abs_filter=abs(abs_filter)/APsize*pi^2;
    %     filter(end/2+1)=filter(end/2);
    window_type=1;
    switch window_type
        case 1  % 矩形窗
            window_arr=ones(1,APsize);
        case 2  % Shepp-Logan窗
            window_arr = abs(sinc(abs_filter));
        case 3  % Hamming窗
            c=0.54;
            window_arr = c - (1-c)*cos(2*pi*[-APsize/2:APsize/2-1]/APsize);
        otherwise %不滤波
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
    
    
    %反投影
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
    
    %令视野外的值为0
    [X,Y]=meshgrid(1:Isize);
    cid=(((X-Isize/2).^2+(Y-Isize/2).^2)>(Isize/2)^2);
    ReBdImg(cid)=0;
    
end

if Method==2
    Psize=size(ProjImg,1);
    Iangle=length(theta);
    Augsize=floor(Psize*(sqrt(2)-1)/2);
    ProjImg=[zeros(Augsize,Iangle);ProjImg;zeros(Augsize,Iangle)];
    ReBdImg=iradon(ProjImg,theta,'linear','Ram-Lak',1,Isize);
end






end

