clc,clear
close all
% 
% funcpath='E:\近期进展\几何参数校正\GeometryErrorCorrection\GeometryErrorCorrection\Correction_matlab\Method2\functions';
% output_path='E:\近期进展\几何参数校正\data\process\data1.2\';
% addpath(funcpath)
%% 投影数据的构造过程
Isize=512;
theta=1:180;
Iangle=length(theta);
orig_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Isize),'.raw'];
proj_lastname=[' float ',num2str(Isize),'x',num2str(Isize),'x',num2str(Iangle),'.raw'];

if 0
OriImg=zeros(Isize,Isize,Isize);
tx=1:Isize;
[TX,TY,TZ]=meshgrid(tx,tx,tx);
CId=ones(1,3)*Isize/2;

% 主体球
MainR=Isize/3;
zoomM=CId;
MainId01=(TX-zoomM(1)).^2+(TY-zoomM(2)).^2+(TZ-zoomM(3)).^2<MainR^2;
MainId=MainId01;
OriImg(MainId)=4.7*1e-6/32;

% 小球1
Ball01R=MainR/8;
zoomB01=[-MainR/2 MainR/2 48]+CId;
B01Id=(TX-zoomB01(1)).^2+(TY-zoomB01(2)).^2+(TZ-zoomB01(3)).^2<Ball01R^2;
OriImg(B01Id)=51.5*1e-6/32;

% 方块1
Sq01L=MainR/8;
zoomSq01=[MainR/2 MainR/2 16]+CId;
Sq01Id=((abs(TX-zoomSq01(1))<Sq01L)+(abs(TY-zoomSq01(2))<Sq01L)+(abs(TZ-zoomSq01(3))<Sq01L))>2;
OriImg(Sq01Id)=51.5*1e-6/32;
%
% 圆柱1
Cder01R=MainR/8;
Cder01H=MainR/8;
zoomCder01=[MainR/2 -MainR/2 -16]+CId;
Cder01Id=(TX-zoomCder01(1)).^2+(TY-zoomCder01(2)).^2<Cder01R^2;
Cder01Id=((abs(TZ-zoomCder01(3))<Cder01H)+Cder01Id)>1;
OriImg(Cder01Id)=51.5*1e-6/32;

% 圆锥1
Cone01R=MainR/8;
Cone01H=MainR/8;
zoomCone01=[-MainR/2 -MainR/2 -48]+CId;
Cone01Id=(TX-zoomCone01(1)).^2+(TY-zoomCone01(2)).^2-(TZ-zoomCone01(3)-Cone01H).^2/4<0;
Cone01Id=(abs(TZ-zoomCone01(3))<Cone01H)+Cone01Id>1;
OriImg(Cone01Id)=51.5*1e-6/32;
ProjImgO=Radon3D(OriImg,theta,1);

WriteImgToFile(['OriImg',orig_lastname],OriImg,'float32');
WriteImgToFile(['ProjImgO',proj_lastname],ProjImgO,'float32');

end

%% 生成随机竖直抖动，水平抖动以及随机摇摆角
if 1
    ProjImgO=ReadFileToImg(['ProjImgO',proj_lastname],Isize,Isize,'float32');
    Am_x=randn(1,Iangle)*4;
    Am_y=randn(1,Iangle)*4;
    Ath_z=rand(1,Iangle)*4-2;
    Am_x=round(Am_x);
    Am_y=round(Am_y);
    Ath_z=round(Ath_z*10)/10;
    xlswrite(['OriErr.xls'],[Am_x' Am_y' Ath_z']);
    
%     %先旋转后平移
%     ProjImg=ImgTrans3D(ProjImgO,Am_x*0,Am_y*0,Ath_z);     
%     ProjImg=ImgTrans3D(ProjImg,-Am_x,-Am_y,Ath_z*0);
    %先平移后旋转
    ProjImg=ImgTrans3D(ProjImgO,Am_x,Am_y,Ath_z);    
    
    
%     WriteImgToFile([output_path,'ProjImg',proj_lastname],ProjImg,'float32');
%     clear ProjImgO
end



