%% ����ͼƬ
load theta_0;
load theta_01;
load theta_001;
load theta_0001;

%% ����Ҷ�任����ʵ�����鲿���������λ
[Re0,Im0,ab0,ang0]=furo(theta_0);
[Re1,Im1,ab1,ang1]=furo(theta_01);
[Re2,Im2,ab2,ang2]=furo(theta_001);
[Re3,Im3,ab3,ang3]=furo(theta_0001);

%% �Ա����
ab=[ab0(128),ab1(128),ab2(128),ab3(128)];