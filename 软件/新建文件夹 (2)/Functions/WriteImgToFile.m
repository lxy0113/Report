function [states] = WriteImgToFile(filename,Data,format_type)
%% 保存二进制文件
% filename 文件名
% Data 数据
% format_type 数据类型：float,double,int等
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
    disp('文件保存失败！');
    states=0;
    return
end
% figure,imshow(Imgdata,[]);
fclose(fid);



end