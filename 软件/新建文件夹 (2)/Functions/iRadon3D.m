function ReBdImg=iRadon3D(ProjImg,theta,linesgap)
%% iRadon3D 三维FBP
% 实现过程按2D的FBP分层重建

if nargin==2
    linesgap=1;
end
if length(size(ProjImg))==3
    [projsize,~,angs]=size(ProjImg);
    Isize=projsize*linesgap;%重建图的大小
    
    ReBdImg=zeros(Isize,Isize,Isize);
    disp('重建中...')
    for i=1:Isize
        %    disp([num2str(i),'/',num2str(Isize)]);
        Ptemp2D=reshape(ProjImg(i,:,:),Isize,angs);
        RBtemp2D=iradon(Ptemp2D,theta,'linear','Ram-Lak',1,projsize);
        ReBdImg(:,:,i)=imresize(RBtemp2D,1/linesgap);
    end
    
end
if length(size(ProjImg))==2
    [projsize,~]=size(ProjImg);
    Isize=projsize*linesgap;%重建图的大小
    ReBdImg=iradon(ProjImg,theta,'linear','Ram-Lak',1,Isize);
    
    [Xid,Yid]=meshgrid(1:Isize,1:Isize);
    cid=((Xid-Isize/2).^2+(Yid-Isize/2).^2>(Isize/2)^2);
    ReBdImg(cid)=0;
end




