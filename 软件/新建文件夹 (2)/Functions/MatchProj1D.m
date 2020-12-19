function [ P1_cor,Mx_cor ] = MatchProj1D( P1,P2,Method )
%MatchProj1D 一维的投影匹配
%   P1 待修正投影
%   P2 参考投影
%   P1_cor 修正投影
%   Method 方法
%   1:(默认）利用参考投影校正一个投影
%   2：利用相邻投影匹配修正sino图

Mx_cor=0;
if nargin==2
    Method=1;
end

if nargin==1
    Method=2;
    [Isize,Iangle]=size(P1);
end


if Method==1
   seek_Mx=-20:20;
   Err=zeros(1,length(seek_Mx));
   for i=1:length(seek_Mx)
       P1t=ImgTrans1D(P1,seek_Mx(i));
       Err(i)=mean((P2-P1t).^2);
   end
   sMx=seek_Mx(Err==min(Err));
   P1_cor=ImgTrans1D(P1,sMx);
end

if Method==2
    proj0=P1;
    clear P1
    
    Mx_cor=zeros(1,Iangle);
    for i=1:Iangle-1
        P1=proj0(:,i);
        P2=proj0(:,i+1);
        fP1=fftshift(fft(fftshift(P1)));
        fP2=fftshift(fft(fftshift(P2)));
        err=angle(fP1./fP2)*Isize/(2*pi);
        err=-round(err(end/2)/1);
        if err>=0
%             P1t=[zeros(err,1);P1(1:end-err)];
            P2t=[P2(err+1:end);zeros(err,1)];
        else
%             P1t=[P1(1:end+err);zeros(-err,1)];
            P2t=[zeros(-err,1);P2(1:end+err)];
        end
%         proj0(:,i)=P1t;
        proj0(:,i+1)=P2t;
%         figure(3)
%         imshow(proj0',[])
%         pause(0.05)


    Mx_cor(i+1)=err;
    end
    P1_cor=proj0;

end





end

