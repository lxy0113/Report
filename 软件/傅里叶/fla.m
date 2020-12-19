% tic;
% tt=imresize(ProjImgO(:,:,1),10);
% toc;

%图像平移

%translate(SE, [y x])在结构元素SE上进行y和x方向的位移 正数对应右移和下移
se=translate(strel(1),[m_x(i)*10 m_y(i)*10]);
B=imdilate(ProjImgO(:,:,i),se);%形态学膨胀
figure;
subplot(1,2,1),imshow(ProjImgO(:,:,1),[]);
title('原图像')
subplot(1,2,2),imshow(B,[]);
title('图像平移')