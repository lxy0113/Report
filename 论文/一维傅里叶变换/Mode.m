%% 设置模体
function [I]=Mode(n,N)
I=zeros(N,N,N);
Isize=N;
I=zeros(Isize,Isize,Isize);
%一个球一个长方体
if(n==1)  
    center=[N/4,N/4,N/4];
   
    if(N==128)
        r=4;
        I(84:96,92:103,28:36)=0.5;
    end
    if(N==256)
         r=8;
        I(164:170,156:160,184:194)=0.5;
    end
    if(N==512)
        r=4;
        I(101:110,90:104,84:94)=0.5;
    end
    [A,B,C]=meshgrid(-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5,-N/2+0.5:N/2-0.5);
    I((A-center(1)).^2+(B-center(2)).^2+(C-center(3)).^2<=r^2)=1;
end
if(n==2)
    tx=1:Isize;
    [TX,TY,TZ]=meshgrid(tx,tx,tx);
    CId=ones(1,3)*Isize/2; 
    % 主体球
    MainR=Isize/2-2;
    zoomM=CId;
    MainId01=(TX-zoomM(1)).^2+(TY-zoomM(2)).^2+(TZ-zoomM(3)).^2<MainR^2;
    MainId=MainId01;
    I(MainId)=4.7*1e-6/32;
     % 主体球2
    MainR=Isize/2-10;
    zoomM=CId;
    MainId01=(TX-zoomM(1)).^2+(TY-zoomM(2)).^2+(TZ-zoomM(3)).^2<MainR^2;
    MainId=MainId01;
    I(MainId)=2.7*1e-6/32;
    % 小球1;
    Ball01R=MainR/8;
    zoomB01=[-MainR/8 0 0]+CId;
    B01Id=(TX-zoomB01(1)).^2+(TY-zoomB01(2)).^2+(TZ-zoomB01(3)).^2<Ball01R^2;
    I(B01Id)=21.5*1e-6/32;
    %椭球2;
    a=MainR/8+10;b=MainR/8;c=MainR/8-10;
    zoomB01=[-a 0 0]+CId;
    B01Id=((TX-zoomB01(1)).^2)/(a^2)+((TY-zoomB01(2)).^2)/(b^2)+((TZ-zoomB01(3)).^2)/(c^2)<1;
    I(B01Id)=21.5*1e-6/32;
end
if(n==3)
    Isize=N;
    I=zeros(Isize,Isize,Isize);
    tx=1:Isize;
    [TX,TY,TZ]=meshgrid(tx,tx,tx);
    CId=ones(1,3)*Isize/2; 
    % 主体球
    MainR=Isize/3;
    zoomM=CId;
    MainId01=(TX-zoomM(1)).^2+(TY-zoomM(2)).^2+(TZ-zoomM(3)).^2<MainR^2;
    MainId=MainId01;
    I(MainId)=4.7*1e-6/32;
    % 小球;1
    Ball01R=MainR/8;
    zoomB01=[-MainR/2 MainR/2 48]+CId;
    B01Id=(TX-zoomB01(1)).^2+(TY-zoomB01(2)).^2+(TZ-zoomB01(3)).^2<Ball01R^2;
    I(B01Id)=51.5*1e-6/32;
    % 方块1
    Sq01L=MainR/8;
    zoomSq01=[MainR/2 MainR/2 16]+CId;
    Sq01Id=((abs(TX-zoomSq01(1))<Sq01L)+(abs(TY-zoomSq01(2))<Sq01L)+(abs(TZ-zoomSq01(3))<Sq01L))>2;
    I(Sq01Id)=51.5*1e-6/32;
    % 圆柱1
    Cder01R=MainR/8;
    Cder01H=MainR/8;
    zoomCder01=[MainR/2 -MainR/2 -16]+CId;
    Cder01Id=(TX-zoomCder01(1)).^2+(TY-zoomCder01(2)).^2<Cder01R^2;
    Cder01Id=((abs(TZ-zoomCder01(3))<Cder01H)+Cder01Id)>1;
    I(Cder01Id)=51.5*1e-6/32;
    % 圆锥1
    Cone01H=MainR/8;
    zoomCone01=[-MainR/2 -MainR/2 -48]+CId;
    Cone01Id=(TX-zoomCone01(1)).^2+(TY-zoomCone01(2)).^2-(TZ-zoomCone01(3)-Cone01H).^2/4<0;
    Cone01Id=(abs(TZ-zoomCone01(3))<Cone01H)+Cone01Id>1;
    I(Cone01Id)=51.5*1e-6/32;
end
end