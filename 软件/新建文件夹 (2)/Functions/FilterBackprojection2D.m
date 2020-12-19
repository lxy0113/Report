function ReBd = FilterBackprojection2D(ProjImg,xlabel,theta,Isize,filtertype)
%% FilterBackprojection2D 2D��FBP�㷨
% ProjImg ͶӰͼ��ע�������ͶӰͼ��ÿ�б�ʾһ��ͶӰ�Ƕ��µ�ͶӰ��
% xlabel ̽��������
% theta �Ƕ�����
% Isize ���ؽ�ͼ��С
% filtertype �˲�����

%% �����������趨
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
        % ��������
end

dtheta=length(theta)/angs;  %�Ƕȼ��
dl=length(xlabel)/rays;     %̽�������
enlargefft=2;               %����fft������

%% FFT
% rays=2*rays;

width = 2^nextpow2(rays)*2^enlargefft;
dl=width/rays;
PImg_fft=fft(ProjImg,width,1);
PImg_fft=fftshift(PImg_fft);

%% �˲�
PImg_filter=zeros(width,angs);
filter=[width/2:-1:1 0:width/2-1]/rays;    %б���˲���
switch filtertype
    case 1  % ���δ�
        window=zeros(1,width);
        window(1:end)=1;
        filter=filter.*window;
    case 2  % Shepp-Logan��
        window = abs(sinc([width/2:-1:1 0:width/2-1]/width));
        filter=filter.*window;
    case 3  % Hamming��
        c=0.54;
        window = c - (1-c)*cos(2*pi*[width/2:-1:1 0:width/2-1]/width*2);
        filter=filter.*window;
    otherwise %���˲�
        filter=1;
end

% �趨����С
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

%% ��ͶӰ�ؽ�  
ReBd = zeros(rays);      % �趨��ʼֵΪ0

for i=1:angs
   rad=theta(i);
   Rtb1=PImg_ifftr(:,i);
   Rtb2=repmat(Rtb1,1,rays)';
   Rtb3=imrotate(Rtb2,rad,'crop');
%    ReBd=ReBd+Rtb3*dl;
   ReBd=ReBd+Rtb3*1.0;
end
ReBd=ReBd/Isize;


%% ������ߴ�ü��ؽ�ͼ��
cutsize_2=floor((rays-Isize)/2);
if (cutsize_2<=0)
    % ͼ����Ҫ�ü�
else
    ReBd=ReBd(cutsize_2+1:cutsize_2+Isize,cutsize_2+1:cutsize_2+Isize);
end

% figure,imshow(ReBd,[])

end