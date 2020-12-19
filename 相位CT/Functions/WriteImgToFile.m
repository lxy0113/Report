function [states] = WriteImgToFile(filename,Data,format_type)
%% ����������ļ�
% filename �ļ���
% Data ����
% format_type �������ͣ�float,double,int��
fid=fopen(filename,'wb');
[size1,size2,size3]=size(Data);
Datas=zeros(size2,size1,size3);
if(fid>0)
    if(size3>1)
        for i=1:size3
            Datas(:,:,i)=Data(:,:,i)';
        end
    else
        Datas=Data';
    end
    states=fwrite(fid,Datas,format_type);
else
    disp('�ļ�����ʧ�ܣ�');
    states=0;
    return
end
% figure,imshow(Imgdata,[]);
fclose(fid);



end