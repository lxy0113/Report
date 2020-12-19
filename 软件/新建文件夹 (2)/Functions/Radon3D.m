function ProjImg=Radon3D(OriImg,theta,linesgap)
%% 3D���ݵ�ͶӰ
%OriImg 3Dԭͼ
%theta �Ƕȷֲ�
%linesgap ���߼��
%ProjImg ͶӰͼ��

if nargin==2
    linesgap=1;
end

angs=length(theta);
Isize=size(OriImg,1);
projsize=floor(Isize/linesgap);
OriImg_p=imresize(OriImg,1/linesgap);%����������������ԭʼͼ���С


[~,xL]=radon(zeros(projsize),1);
ProjImg=zeros(projsize,length(xL),angs);
disp('ͶӰ��...')
for i=1:projsize
%    disp([num2str(i),'/',num2str(projsize)]);        
   ProjImg(i,:,:)=radon(OriImg_p(:,:,i),theta);
end

cutsize=length(xL)-projsize;
cutsize=floor(cutsize/2)*2;
ProjImg(:,1:cutsize/2+1,:)=[];
ProjImg(:,end-cutsize/2+1:end,:)=[];


end