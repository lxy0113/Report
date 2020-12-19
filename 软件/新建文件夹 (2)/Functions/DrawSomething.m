function [Img,x,y]=DrawSomething(Isize,type)

t=(1:Isize)-0.5;
[X,Y]=meshgrid(t,t);
x=X-Isize/2;
y=Y-Isize/2;


if nargin==1
   type=1; 
end

if type==1
    Img=ones(Isize);
    Img(abs(x)>Isize/16)=0;
    Img(abs(y)>Isize/16)=0;
end
if type==1.1
    Img=ones(Isize);
    Img(abs(x)>Isize/8)=0;
    Img(abs(y)>Isize/8)=0;
end



if type==2
    Img=zeros(Isize);
    Img(x.^2+y.^2<Isize^2/4)=0.5;
    Img(x.^2+(y-Isize/4).^2<Isize^2/128)=1;
end

% exp(-x.^2-y.^2)
if type==3
    L=8;
    x=x/(Isize/2)*L;
    y=y/(Isize/2)*L;
    Img=exp(-x.^2-y.^2);
end

% pi*exp(-pi^2*(u.^2+v.^2)
if type==4
    L=8;
    x=x/(Isize/2)*L;
    y=y/(Isize/2)*L;
    Img=pi*exp(-pi^2*(x.^2+y.^2));
end

if type==5
    Img=zeros(Isize);
    Img(x.^2+y.^2<Isize^2/4)=0.5;
    Img(x.^2+(y-Isize/4).^2<Isize^2/128)=1;
    Img(x.^2+(y+Isize/4).^2<Isize^2/128)=-1;
end

if type==6
    Img=zeros(Isize);
    roundid1=x.^2+y.^2<(Isize/2.5)^2;
    Img(roundid1)=0.2;
    roundid2=(x-Isize/8).^2+(y+Isize/8).^2<(Isize/16)^2;
    Img(roundid2)=1;
    roundid3=(x-Isize/8).^2+(y-Isize/8).^2<(Isize/8)^2;
    Img(roundid3)=1;
    roundid4=(x+Isize/8).^2+(y+Isize/8).^2<(Isize/8)^2;
    Img(roundid4)=1; 
end


if type==7
    Img=zeros(Isize);
    roundid1=x.^2+y.^2<(Isize/2.5)^2;
    Img(roundid1)=0.2;
    roundid2=(x-Isize/8).^2+(y+Isize/8).^2<(Isize/16)^2;
    Img(roundid2)=1;
%     roundid3=(x-Isize/8).^2+(y-Isize/8).^2<(Isize/16)^2;
%     Img(roundid3)=1;
    
    
    roundid4=((abs(x-Isize/8)<Isize/16)+(abs(y-Isize/8)<Isize/16))>1;
    Img(roundid4)=1; 
end





