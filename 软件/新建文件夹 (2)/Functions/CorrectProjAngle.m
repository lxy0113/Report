function [ ProjData_cor,Correct_angle ] = CorrectProjAngle( StandP,ProjData_err,seekangle,Method )
%CorrectProjAngle ͨ��һ��ͶӰ�Ƕ��±�׼��ͶӰ��У��һϵ��ͶӰ�Ƕ��´�����ͶӰ
%   StandP ��׼��ͶӰ
%   ProjData_err ������һϵ��ͶӰ
%   seekangle �����Ƕ�
%   Method ������1.ʵ�����ͶӰ����У����Ĭ�ϣ�
%               2.Ƶ��������Ƭ����ʽУ��

if nargin==2
    seekangle=-10:10;
    Method=2;
end
[Isize,~,Iangle]=size(ProjData_err);
Skangs=length(seekangle);
ProjData_cor=zeros(Isize,Isize,Iangle);
Correct_angle=zeros(1,Iangle);

sP2=sum(StandP,2);

if Method==1
    for i=1:Iangle
        Y=ProjData_err(:,:,i);
        Err_re=zeros(1,Skangs);
        for j=1:Skangs
            seek_t=seekangle(j);
            Y_t=imrotate(Y,seek_t,'crop','bilinear');
            sY_t=sum(Y_t,2);
            Err_re(j)=sum(abs(sP2-sY_t));
        end
        Correct_angle(i)=seekangle(Err_re==min(Err_re));
    end
    
end

if Method==2
    fsP2=fft(fftshift(sP2));

% ��ʵ������
% resP2=real(fftshift(fsP2));
% for i=1:Iangle
%     Y=ProjData_err(:,:,i);
%     [~,refY,~,~,~]=FFT2D(Y);
%     Err_abs=zeros(1,Skangs);
%     for j=1:Skangs
%         seek_t=seekangle(j);
%         refY_t=DragLine(fftshift(refY),seek_t);
%         Err_abs(j)=sum(abs((resP2-refY_t').^2));
%     end
%     Correct_angle(i)=seekangle(Err_abs==min(Err_abs));
% end

% ���鲿����
% imP2=imag(fftshift(fsP2));
% for i=1:Iangle
%     Y=ProjData_err(:,:,i);
%     [~,~,imfY,~,~]=FFT2D(Y);
%     Err_abs=zeros(1,Skangs);
%     for j=1:Skangs
%         seek_t=seekangle(j);
%         imfY_t=DragLine(fftshift(imfY),seek_t);
%         Err_abs(j)=sum(abs((imP2-imfY_t').^2));
%     end
%     Correct_angle(i)=seekangle(Err_abs==min(Err_abs));
% end

% ��ģ����
absP2=abs(fftshift(fsP2));
for i=1:Iangle
    Y=ProjData_err(:,:,i);
    [~,~,~,absfY,~]=FFT2D(Y);
    Err_abs=zeros(1,Skangs);
    for j=1:Skangs
        seek_t=seekangle(j);
        absfY_t=DragLine(fftshift(absfY),seek_t);
        Err_abs(j)=sum(abs(absP2-absfY_t'));
        
        
%         figure(2),plot(seekangle,Err_abs);
%         xlabel(['theta = ',num2str(i)])
        
        
    end
    Correct_angle(i)=seekangle(Err_abs==min(Err_abs));
    
    if (i<=90 || i>178)
        Correct_angle(i)=-Correct_angle(i);
    end
    
%     figure(3),plot(Correct_angle);
%     pause(0.1)
end

% �÷��ǹ���
% angP2=angle(fftshift(fsP2));
% for i=1:Iangle
%     Y=ProjData_err(:,:,i);
%     [~,~,~,~,angfY]=FFT2D(Y);
%     Err_abs=zeros(1,Skangs);
%     for j=1:Skangs
%         seek_t=seekangle(j);
%         angfY_t=DragLine(fftshift(angfY),seek_t);
%         Err_abs(j)=sum(abs((angP2-angfY_t').^2));
%     end
%     Correct_angle(i)=seekangle(Err_abs==min(Err_abs));
% end


end


if Method==3
    fsP2=fft(fftshift(sP2));
    absP2=abs(fftshift(fsP2));
    for i=1:Iangle
        Y=ProjData_err(:,:,i);
        Err_abs=zeros(1,Skangs);
        for j=1:Skangs
            seek_t=seekangle(j);
            Y_t=imrotate(Y,seek_t,'crop','bilinear');
            sY_t=sum(Y_t,2);
            fsY_t=fft(fftshift(sY_t));
            absfsY_t=abs(fftshift(fsY_t));
            Err_abs(j)=sum(abs(absP2-absfsY_t));
            
        end
        Correct_angle(i)=seekangle(Err_abs==min(Err_abs));
        ProjData_cor(:,:,i)=imrotate(Y,Correct_angle(i),'crop','bilinear');
    end
    
    
end




end

