
[X,Y]=meshgrid(-N/2+0.5:N/2-0.5,-M/2+0.5:M/2-0.5);
[Rx,Ry]=meshgrid(-N/2+N_step/2:N_step:N/2-N_step/2,-M/2+M_step/2:M_step:M/2-M_step/2);
theta=1:180;
 erro=zeros(nbins,nbins);
for iter=1:k_final
    for i=1:nviews
        % p��ʾ��ʵ�ĵ�i���Ƕ��µ���Ͷͼ
        % x��ʾ�ؽ������i���Ƕ��µ���Ͷͼ
        %error��ʾp��x���
        error=(p(i,:,:)-dis*ipro1_3Diproj_3D(I,dis,angle(i),nviews,nbins,i))/N;
        for j=1:N
            for k=1:N
                erro(j,k)=error(i,j,k);
            end
        end
        Xray=Rx.*cosd(theta(i))+Ry.*sind(theta(i));
        orth=interp2(X,Y,erro,Xray,Yray,'linear',0);  
        I=I+orth;
    end   
    I(I<0)=0;
    I(I>1)=1;                                                    
end

