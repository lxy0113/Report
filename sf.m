function [output_img]=Scale(img,scale_size)
[h,w] = size(img); %获取行和列，即原图的高度和宽度
 
scale_w = scale_size(1); %根据输入获得缩放后的新宽度
scale_h = scale_size(2); %根据输入获得缩放后的新高度
output_img = zeros(scale_h, scale_w); %初始化
 
for i = 1 : scale_h         %缩放后的图像的（i,j）位置对应原图的（x,y）
    for j = 1 : scale_w
        x = i * h / scale_h;
        y = j * w / scale_w;
        u = x - floor(x);
        v = y - floor(y); %取小数部分
        
        if x < 1           %边界处理
            x = 1;
        end
        
        if y < 1
            y = 1;
        end
        
 
        %用原图的四个真实像素点来双线性插值获得“虚”像素的像素值
        output_img(i, j) = img(floor(x), floor(y)) * (1-u) * (1-v) + ...
                               img(floor(x), ceil(y)) * (1-u) * v + ...
                               img(ceil(x), floor(y)) * u * (1-v) + ...
                               img(ceil(x), ceil(y)) * u * v;
    end
end
