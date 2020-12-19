function [output_img]=Scale(img,scale_size)
[h,w] = size(img); %��ȡ�к��У���ԭͼ�ĸ߶ȺͿ��
 
scale_w = scale_size(1); %�������������ź���¿��
scale_h = scale_size(2); %�������������ź���¸߶�
output_img = zeros(scale_h, scale_w); %��ʼ��
 
for i = 1 : scale_h         %���ź��ͼ��ģ�i,j��λ�ö�Ӧԭͼ�ģ�x,y��
    for j = 1 : scale_w
        x = i * h / scale_h;
        y = j * w / scale_w;
        u = x - floor(x);
        v = y - floor(y); %ȡС������
        
        if x < 1           %�߽紦��
            x = 1;
        end
        
        if y < 1
            y = 1;
        end
        
 
        %��ԭͼ���ĸ���ʵ���ص���˫���Բ�ֵ��á��顱���ص�����ֵ
        output_img(i, j) = img(floor(x), floor(y)) * (1-u) * (1-v) + ...
                               img(floor(x), ceil(y)) * (1-u) * v + ...
                               img(ceil(x), floor(y)) * u * (1-v) + ...
                               img(ceil(x), ceil(y)) * u * v;
    end
end
