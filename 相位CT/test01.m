clc,clear
close all;

addpath('Images\')
addpath('Functions\')
% 利用傅立叶变换进行参数校正
%% 图像与参数的初始设定
Isize=512;                                                              %图像尺寸
ProjImg=ReadFileToImg('ProjImg float 512x512x181.raw',Isize,Isize,'float32');
Iangle=size(ProjImg,3);
Imglastname1=[' float ',num2str(Isize),'x',num2str(Isize),'.raw'];       %图像文件名后缀1
Imglastname2=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Iangle),'.raw'];
%图像文件名后缀2


%% 将原始数据在不同角度下进行旋转和平移
theta_Rotate=randn(1,Iangle);
move_mx=round(rand(1,Iangle)*20-10);
move_my=round(rand(1,Iangle)*20-10);
ProjImg_r=ProjImg;
ProjImg_m=ProjImg;
ProjImg_err=ProjImg;

seekangle=-5:0.2:5;

% xlswrite('theta_Rotate',theta_Rotate');
xlswrite('RandErr',[move_mx' move_my' theta_Rotate']);
% figure(1),plot(1:Iangle,theta_Rotate);

for i=1:Iangle
    ProjImg_r(:,:,i)=TransImg(ProjImg_r(:,:,i),0,0,theta_Rotate(i));
end

for i=1:Iangle
    ProjImg_m(:,:,i)=TransImg(ProjImg_m(:,:,i),move_mx(i),move_my(i));
end

for i=1:Iangle
    ProjImg_err(:,:,i)=TransImg(ProjImg_err(:,:,i),move_mx(i),move_my(i),theta_Rotate(i));
end





% WriteImgToFile(['ProjImg_r ',Imglastname2],ProjImg_r,'float32');
% WriteImgToFile(['ProjImg_m ',Imglastname2],ProjImg_m,'float32');
% WriteImgToFile(['ProjImg_err ',Imglastname2],ProjImg_err,'float32');

%% 找出理想的投影
if 0
alpha1=1;
alpha2=90;
[theta_Rotate(alpha1),theta_Rotate(alpha2)]
RoX=ProjImg_err(:,:,alpha1);
RoY=ProjImg_err(:,:,alpha2);
seekangle=-5:0.1:5;% 角度遍历范围

[Err01,thetaX,thetaY]=GetRotateError(RoX,RoY,seekangle,3);
[theta_Rotate(alpha1)+thetaX,theta_Rotate(alpha2)+thetaY]
end

%% 依次对不同投影角度进行角度校正
if 0
X=ProjImg(:,:,1);
[~,Correct_angle]=CorrectProjAngle(X,ProjImg_r,seekangle,3);

figure(3),plot(1:Iangle,-Correct_angle,1:Iangle,theta_Rotate)
legend('Correct','Rotate')

end

%% 依次对不同投影角度进行平移校正
if 0
    
    [M_x,M_y]=CorrectProjMove(ProjImg,ProjImg_m);
    
    
    figure(1),plot(1:Iangle,move_mx,1:Iangle,M_x,'*')
    figure(2),plot(1:Iangle,move_my,1:Iangle,M_y,'*')
end


%% 综合校正
if 0
    X=ProjImg(:,:,1);
    [~,Correct_angle]=CorrectProjAngle(X,ProjImg_err,seekangle,3);
    
    figure(3),plot(1:Iangle,-Correct_angle,1:Iangle,theta_Rotate)
    legend('Correct','Rotate')
    
    
end

if 1
   [ ProjImg_cor ] = CorrectProj01( ProjImg_err,1 );
   WriteImgToFile(['ProjImg_cor ',Imglastname2],ProjImg_cor,'float32');
end









