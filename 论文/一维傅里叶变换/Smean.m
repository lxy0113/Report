%% �������Ա�
%% OriImgԭͼ��A��׼��Ͷͼ�ؽ������B������/�ڶ��Ľ����
function [c1,c2]=Smean(OriImg,A,B)
[M,N,Z]=size(OriImg);   
%% ��ԭͼ�ľ������
E=imsubtract(B,OriImg);
avg1=mean2(E);
s1=0;
for i=1:M
    for j=1:N
        for k=1:Z
            s1=s1+(E(i,j,k)-avg1)^2;
        end
    end
end
c1=s1/(M*N*Z);
%% ���׼��Ͷͼ�ؽ�ͼ�ľ������
E1=imsubtract(B,A);
avg2=mean2(E1);
s1=0;
for i=1:M
    for j=1:N
        for k=1:Z
            s1=s1+(E1(i,j,k)-avg2)^2;
        end
    end
end
c2=s1/(M*N*Z);    
end

