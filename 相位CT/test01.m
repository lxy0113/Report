clc,clear
close all;

addpath('Images\')
addpath('Functions\')
% ���ø���Ҷ�任���в���У��
%% ͼ��������ĳ�ʼ�趨
Isize=512;                                                              %ͼ��ߴ�
ProjImg=ReadFileToImg('ProjImg float 512x512x181.raw',Isize,Isize,'float32');
Iangle=size(ProjImg,3);
Imglastname1=[' float ',num2str(Isize),'x',num2str(Isize),'.raw'];       %ͼ���ļ�����׺1
Imglastname2=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Iangle),'.raw'];
%ͼ���ļ�����׺2


%% ��ԭʼ�����ڲ�ͬ�Ƕ��½�����ת��ƽ��
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

%% �ҳ������ͶӰ
if 0
alpha1=1;
alpha2=90;
[theta_Rotate(alpha1),theta_Rotate(alpha2)]
RoX=ProjImg_err(:,:,alpha1);
RoY=ProjImg_err(:,:,alpha2);
seekangle=-5:0.1:5;% �Ƕȱ�����Χ

[Err01,thetaX,thetaY]=GetRotateError(RoX,RoY,seekangle,3);
[theta_Rotate(alpha1)+thetaX,theta_Rotate(alpha2)+thetaY]
end

%% ���ζԲ�ͬͶӰ�ǶȽ��нǶ�У��
if 0
X=ProjImg(:,:,1);
[~,Correct_angle]=CorrectProjAngle(X,ProjImg_r,seekangle,3);

figure(3),plot(1:Iangle,-Correct_angle,1:Iangle,theta_Rotate)
legend('Correct','Rotate')

end

%% ���ζԲ�ͬͶӰ�ǶȽ���ƽ��У��
if 0
    
    [M_x,M_y]=CorrectProjMove(ProjImg,ProjImg_m);
    
    
    figure(1),plot(1:Iangle,move_mx,1:Iangle,M_x,'*')
    figure(2),plot(1:Iangle,move_my,1:Iangle,M_y,'*')
end


%% �ۺ�У��
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









