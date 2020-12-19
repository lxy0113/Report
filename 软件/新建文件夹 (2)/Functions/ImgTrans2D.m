function [ Img_out ] = ImgTrans2D( Img_in,mx,my,theta )
%TransImg 图像的平移、旋转变换
%   Img_in 输入图像
%   mx x方向的平移
%   my y方向的平移
%   theta 图像的旋转变换

if nargin==2
    my=0;
    theta=0;
end

if nargin==3
   theta=0; 
end

Isize=size(Img_in,2);
Img_m=Img_in;

if mx==0
    % do nothing
else
    if mx>0
        Img_m=[Img_in(:,mx+1:end) zeros(Isize,mx)];
    else
        Img_m=[zeros(Isize,-mx) Img_in(:,1:end+mx)];
    end
end


if my==0
    %do nothing
else
    if my>0
        Img_m=[Img_m(my+1:end,:);zeros(my,Isize)];
    else
        Img_m=[zeros(-my,Isize);Img_m(1:end+my,:)];
    end
end




Img_r=imrotate(Img_m,theta,'crop','bilinear');

Img_out=Img_r;

end

