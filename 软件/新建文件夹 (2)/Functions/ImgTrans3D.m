function [ Img3d_output ] = ImgTrans3D( Img3d_input,M_X,M_Y,THETA)
%ImgTrans3D 图像的平移
% Img3d_input 输入的三维图像
% 图像按不同页做下面对应参数的变换

% M_X 图像的x方向平移数组
% M_Y 图像的y方向平移数组
% THETA 图像的旋转角度

Pages=size(Img3d_input,3);

if nargin==3
    THETA=M_X*0;
end
if nargin==2
   THETA=M_X*0;
   M_Y=M_X*0;
end


% 参数对应的维度和图像的页数应该相同
if (length(M_X)~=Pages)
    disp('M_X维度不匹配！')
    return
end
if (length(M_Y)~=Pages)
    disp('M_Y维度不匹配！')
    return
end
if (length(M_X)~=Pages)
    disp('THETA维度不匹配！')
    return
end


Img3d_output=Img3d_input;

if nargin==4
    for i=1:Pages
        Img_temp=Img3d_input(:,:,i);
        %M_Y
        m_y=round(M_Y(i));
        if(m_y>0)
            Img_temp(1:end-m_y,:)=Img_temp(1+m_y:end,:);
            Img_temp(end-m_y:end,:)=0;
        else
            Img_temp(1-m_y:end,:)=Img_temp(1:end+m_y,:);
            Img_temp(1:1-m_y,:)=0;
        end
        
        %M_X
        m_x=round(M_X(i));
        if(m_x>0)
            Img_temp(:,1:end-m_x)=Img_temp(:,1+m_x:end);
            Img_temp(:,end-m_x:end)=0;
        else
            Img_temp(:,1-m_x:end)=Img_temp(:,1:end+m_x);
            Img_temp(:,1:1-m_x)=0;
        end
        
        %THETA
        th_z=-THETA(i);
        Img_temp(:,:)=imrotate(Img_temp(:,:),th_z,'bilinear','crop');
        
        Img3d_output(:,:,i)=Img_temp;
    end

end

if nargin==3
    for i=1:Pages
        Img_temp=Img3d_input(:,:,i);
        %M_Y
        m_y=round(M_Y(i));
        if(m_y>0)
            Img_temp(1:end-m_y,:)=Img_temp(1+m_y:end,:);
            Img_temp(end-m_y:end,:)=0;
        else
            Img_temp(1-m_y:end,:)=Img_temp(1:end+m_y,:);
            Img_temp(1:1-m_y,:)=0;
        end
        
        %M_X
        m_x=round(M_X(i));
        if(m_x>0)
            Img_temp(:,1:end-m_x)=Img_temp(:,1+m_x:end);
            Img_temp(:,end-m_x:end)=0;
        else
            Img_temp(:,1-m_x:end)=Img_temp(:,1:end+m_x);
            Img_temp(:,1:1-m_x)=0;
        end

        Img3d_output(:,:,i)=Img_temp;
    end
    
end

if nargin==2
    for i=1:Pages
        Img_temp=Img3d_input(:,:,i);
        %M_X
        m_x=round(M_X(i));
        if(m_x>0)
            Img_temp(:,1:end-m_x)=Img_temp(:,1+m_x:end);
            Img_temp(:,end-m_x:end)=0;
        else
            Img_temp(:,1-m_x:end)=Img_temp(:,1:end+m_x);
            Img_temp(:,1:1-m_x)=0;
        end
        
        Img3d_output(:,:,i)=Img_temp;
    end
    
end



end

