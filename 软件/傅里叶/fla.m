% tic;
% tt=imresize(ProjImgO(:,:,1),10);
% toc;

%ͼ��ƽ��

%translate(SE, [y x])�ڽṹԪ��SE�Ͻ���y��x�����λ�� ������Ӧ���ƺ�����
se=translate(strel(1),[m_x(i)*10 m_y(i)*10]);
B=imdilate(ProjImgO(:,:,i),se);%��̬ѧ����
figure;
subplot(1,2,1),imshow(ProjImgO(:,:,1),[]);
title('ԭͼ��')
subplot(1,2,2),imshow(B,[]);
title('ͼ��ƽ��')