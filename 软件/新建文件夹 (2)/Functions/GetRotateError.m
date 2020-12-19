function [ Error,thetaX,thetaY ] = GetRotateError( X,Y,theta,Method )
%GetRotateError ��һ���Ƕȷ�Χ����ת����������ͼƬ��ƥ������������ƥ���ͼ���¶�Ӧ�ĽǶ�
%   X,Y ͼ��X,Y
%   theta �����Ƕ�
%   Error ���ص�������
%   Method ����������Ĭ��Ϊ1��

if nargin==2
    theta=-90:90;
    Method=1;
end

if nargin==3
    Method=1;
end

angs=length(theta);
Error=zeros(angs);
Isize=size(X,1);

% ֱ����ʵ���ö���ͶӰƥ��
if Method==1
    for i=1:angs
        RoX=imrotate(X,theta(i),'crop','bilinear');
        sRoX=sum(RoX,2);
        for j=1:angs
            RoY=imrotate(Y,theta(j),'crop','bilinear');
            sRoY=sum(RoY,2);
            Error(i,j)=sum(abs(sRoX-sRoY));
        end
    end
end

% ��Ƶ����������Ƭ����ƥ��
if Method==2
    for i=1:angs
        RoX=imrotate(X,theta(i),'crop','bilinear');
        sRoX=sum(RoX,2);
        fsRoX=fft(fftshift(sRoX));                          %�������ͶӰ��һάfft����fsRoX_t
        refsRoX=real(fftshift(fsRoX));                      %��fsRoX_t��ʵ������refsRoX_t
        
        [~,refY,~,~,~]=FFT2D(Y);                         %����RoY�Ķ�άFFT����ʵ��
        for j=1:angs
            refY_t=DragLine(fftshift(refY),theta(j));
            Error(i,j)=sum(abs(refsRoX-refY_t'));
            
            
%             figure(1)
%             plot(1:Isize,refsRoX,1:Isize,refY_t)
%             legend('refsRoX','refY_t')
%             title(['\theta_i=',num2str(theta(i)),', \theta_j=',num2str(theta(j))])
%             xlabel(['Error = ',num2str(Error(i,j))]);
%             figure(2)
%             plot(theta,Error(i,:))
%             xlabel(['\theta_i=',num2str(theta(i))])
%             pause(0.01)
        end
    end
end

% ֱ����Ƶ���ö���ͶӰƥ��
if Method==3
    for i=1:angs
        RoX=imrotate(X,theta(i),'crop','bilinear');
        sRoX=sum(RoX,2);
        fsRoX=fftshift(fft(fftshift(sRoX)));
        absfsRoX=abs(fsRoX);
        for j=1:angs
            RoY=imrotate(Y,theta(j),'crop','bilinear');
            sRoY=sum(RoY,2);
            fsRoY=fftshift(fft(fftshift(sRoY)));
            absfsRoY=abs(fsRoY);
            Error(i,j)=mean(abs(absfsRoX-absfsRoY));
            
            % debug
            if 0
                figure(1)
                imshow([RoX RoY],[])
                xlabel(['\theta(i)=',num2str(theta(i)),', \theta(j)=',num2str(theta(j))])
                figure(2)
                plot([absfsRoX absfsRoY absfsRoX-absfsRoY])
                legend('absfsRoX','absfsRoY','absfsRoX-absfsRoY')
                xlabel(['\theta(i)=',num2str(theta(i)),', \theta(j)=',num2str(theta(j))])
                title(['Err_{mean}=',num2str(Error(i,j))])
                axis([0,inf,-0.05,0.1])
                pause(2)
            end
            %

        end
    end
end


% ֱ��Ѱ����Сֵ����Ӧ�ĽǶ�
[I_idx,J_idx]=find(Error==min(min(Error)));
thetaX=theta(I_idx);
thetaY=theta(J_idx);


end

