function ReBd = FilterBackprojection2D(ProjImg,xlabel,theta,Isize,filtertype)
%% FilterBackprojection2D 2D的FBP算法
% ProjImg 投影图（注意这里的投影图，每列表示一个投影角度下的投影）
% xlabel 探测器坐标
% theta 角度坐标
% Isize 被重建图大小
% filtertype 滤波类型

%% 参数与输入设定
[rays,angs]=size(ProjImg);
switch nargin
    case 1
        xlabel=-rays/2:rays/2-1;
        theta=1:angs;
        Isize=rays;
        filtertype=1;
    case 2
        theta=1:angs;
        Isize=rays;
        filtertype=1;
    case 3
        Isize=rays;
        filtertype=1;
    case 4
        filtertype=1;
    otherwise
        % 正常输入
end

dtheta=length(theta)/angs;  %角度间隔
dl=length(xlabel)/rays;     %探测器间隔
enlargefft=2;               %增大fft采样率

%% FFT
% rays=2*rays;

width = 2^nextpow2(rays)*2^enlargefft;
dl=width/rays;
PImg_fft=fft(ProjImg,width,1);
PImg_fft=fftshift(PImg_fft);

%% 滤波
PImg_filter=zeros(width,angs);
filter=[width/2:-1:1 0:width/2-1]/rays;    %斜坡滤波器
switch filtertype
    case 1  % 矩形窗
        window=zeros(1,width);
        window(1:end)=1;
        filter=filter.*window;
    case 2  % Shepp-Logan窗
        window = abs(sinc([width/2:-1:1 0:width/2-1]/width));
        filter=filter.*window;
    case 3  % Hamming窗
        c=0.54;
        window = c - (1-c)*cos(2*pi*[width/2:-1:1 0:width/2-1]/width*2);
        filter=filter.*window;
    otherwise %不滤波
        filter=1;
end

% 设定窗大小
winsize=rays;
if winsize<width
    window=zeros(1,width);
    window(floor(end/2-winsize/2):floor(end/2+winsize/2))=1;
    filter=filter.*window;
else
    %do nothing
end

% figure,plot(filter);

for i=1:angs
    PImg_filter(:,i)=PImg_fft(:,i).*filter';
end

%% IFFT
PImg_filter=fftshift(PImg_filter);
PImg_ifft=ifft(PImg_filter,width,1);
PImg_ifftr=real(PImg_ifft);
PImg_ifftr(rays+1:width,:)=[];

%% 反投影重建  
ReBd = zeros(rays);      % 设定初始值为0

for i=1:angs
   rad=theta(i);
   Rtb1=PImg_ifftr(:,i);
   Rtb2=repmat(Rtb1,1,rays)';
   Rtb3=imrotate(Rtb2,rad,'crop');
%    ReBd=ReBd+Rtb3*dl;
   ReBd=ReBd+Rtb3*1.0;
end
ReBd=ReBd/Isize;


%% 按所需尺寸裁剪重建图像
cutsize_2=floor((rays-Isize)/2);
if (cutsize_2<=0)
    % 图像不需要裁剪
else
    ReBd=ReBd(cutsize_2+1:cutsize_2+Isize,cutsize_2+1:cutsize_2+Isize);
end

% figure,imshow(ReBd,[])

end