function Imgdata = ReadFileToImg(filename,width,height,format_type)
%% ��ȡ������ͼ��
% filename �ļ���
% width ͼ���
% height ͼ���
% format_type �������ͣ�float,double,int��



fid=fopen(filename,'rb');
if(fid>0)
    Imgdata=fread(fid,inf,format_type);
    page=length(Imgdata)/(width*height);
    if page>floor(page)
        disp('����ߴ�ָ����ƥ�䣡');
        return
    end

    %���·ֲ�����ά��
    if page==1
        Imgdata=reshape(Imgdata,width,height);
        Imgdata=Imgdata';
    else
        Imgdata=reshape(Imgdata,width,height,page);
        Imgdata=permute(Imgdata,[2 1 3]);%��ά�����ת�ã��̶����ά�ȴ��򲻱䣬������ת��
    end

else
    disp('�ļ���ȡʧ�ܣ�');
    Imgdata=0;
    return
end
% figure,imshow(Imgdata,[]);
fclose(fid);

end
