function [ ReBdImg ] = iRadon3D( ProjImg,theta,Isize,Method )
%iRadon3D 三维Radon反投影重建

if nargin==2
   Isize=size(ProjImg,2);
   Method=1;
end


[~,DN,AN]=size(ProjImg);
RN=Isize;
dDetect=RN/DN;
ReBdImg=zeros(RN,RN,RN);
disp('重建中...')
tic
for i=1:RN
    Projtemp2D=reshape(ProjImg(i,:,:),RN,AN);
    ReBdtemp2D=iRadon2D(Projtemp2D,theta,RN,Method);
    ReBdImg(:,:,i)=imresize(ReBdtemp2D,1/dDetect);
end
toc


end

