function Imgdata = ReadFileToImg(filename,width,height,format_type)
%% 读取二进制图像
% filename 文件名
% width 图像宽
% height 图像高
% format_type 数据类型：float,double,int等



fid=fopen(filename,'rb');
if(fid>0)
    Imgdata=fread(fid,inf,format_type);
    page=length(Imgdata)/(width*height);
    if page>floor(page)
        disp('矩阵尺寸指定不匹配！');
        return
    end

    %重新分布矩阵维度
    if page==1
        Imgdata=reshape(Imgdata,width,height);
        Imgdata=Imgdata';
    else
        Imgdata=reshape(Imgdata,width,height,page);
        Imgdata=permute(Imgdata,[2 1 3]);%三维矩阵的转置，固定层的维度次序不变，对行列转置
    end

else
    disp('文件读取失败！');
    Imgdata=0;
    return
end
% figure,imshow(Imgdata,[]);
fclose(fid);

end
