function ProjImg=Radon3D(OriImg,theta,linesgap)
%% 3D数据的投影
%OriImg 3D原图
%theta 角度分布
%linesgap 射线间隔
%ProjImg 投影图像

if nargin==2
    linesgap=1;
end

angs=length(theta);
Isize=size(OriImg,1);
projsize=floor(Isize/linesgap);
OriImg_p=imresize(OriImg,1/linesgap);%根据射线数量调整原始图像大小


[~,xL]=radon(zeros(projsize),1);
ProjImg=zeros(projsize,length(xL),angs);
disp('投影中...')
for i=1:projsize
%    disp([num2str(i),'/',num2str(projsize)]);        
   ProjImg(i,:,:)=radon(OriImg_p(:,:,i),theta);
end

cutsize=length(xL)-projsize;
cutsize=floor(cutsize/2)*2;
ProjImg(:,1:cutsize/2+1,:)=[];
ProjImg(:,end-cutsize/2+1:end,:)=[];


end