function V = imshow3D(Img,show_nums,id)
%imshow3D 显示3维图像的
if nargin==1
    show_nums=size(Img,3);
    id=1;
end

if nargin==2
    id=1;
end


Page=size(Img,3);
skip=floor(Page/show_nums);


for i=1:show_nums
    figure(id);
%     set (gca,'position',[0.5,0.1,0.2,0.5] );
    imshow(Img(:,:,i*skip),[0,inf],'border','tight','initialmagnification','fit');
    set (gcf,'position',[100,50,1024,1024] );
    pause(0.1);
    text1=text(128,2,[num2str(i*skip),'/',num2str(Page)]);
    text1.Color=[1 0 0];
    text1.FontSize=20;
    text1.HorizontalAlignment='right';
%     xlabel()
end

V=id;


end

