Proj=(ProjImg(:,:,1));
N=512;
% 
% Proj=Proj1(1:N,1:N);
I0 = 5e7;
Max = max(Proj(:));
I1 = I0 * exp(-Proj/Max);
I1 = poissrnd(I1);
I1(I1<1) = 1;
I1(I1>I0) = I0;
orth_proj = -log(I1./I0)*Max;
orth_proj(orth_proj<0) = 0;
Proj = orth_proj;
% c=abs(Proj-ProjImg(:,:,1));
figure
imshow(Proj,[]);
title('a');
P=2*N;
f=zeros(P,P);
fp=zeros(P,P);
f(1:N,1:N)=Proj;
figure
imshow(f,[]);
title('b');
for x=1:P
    for y=1:P
        fp(x,y)=((-1)^(x+y))*f(x,y);
    end
end
figure
imshow(fp,[]);
title('c');
F=fft2(fp);
figure
imshow(real(F),[]);
title('d');
H=zeros(P,P);
D0=50;
% [X,Y]=meshgrid(-N-0.5:N+0.5,-N-0.5:N+0.5);
D=zeros(P,P);
% D(X^2+Y^2<=(D0)^2)=1;
% H=D;
for u=1:P
    for v=1:P
        if((u-N)^2+(v-N)^2<=(D0)^2)
            D(u,v)=1;
        end
    end
end
% H=D;%理想低通
H=1./(1+(D./D0)^2);%布特沃斯
delta=2;
% H=exp(-(D^2)/(2*delta^2));%高斯低通
figure
imshow(H,[]);
title('e');
G=zeros(P,P);
for u=1:P
    for v=1:P
        G(u,v)=F(u,v)*H(u,v);
    end
end
I=real(ifft2(G));
figure
imshow(I,[]);
title('f');
gp=zeros(P,P);
for x=1:P
    for y=1:P
        gp(x,y)=((-1)^(x+y))*I(x,y);
    end
end
figure
imshow(gp,[]);
title('g');
g=gp(1:N,1:N);
figure
imshow(g,[]);
title('h');


























%%
k=1;
c=0:0;
[cm,count]=size(c);
a=ProjImg(:,:,1);
b=Proj;
[zf1,xw1]=mate(a,k,c);
[zf2,xw2]=mate(b,k,c);
t=1000;
for i=1:count
    for j=1:count
        dd=abs(zf1(i)-zf2(j));
        if(dd<t)
            t=dd;
            cx=i;
        end
    end
end

