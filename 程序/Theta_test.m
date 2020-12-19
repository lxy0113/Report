%% 导入图片
load theta_0;
load theta_01;
load theta_001;
load theta_0001;

%% 傅里叶变换，求实部、虚部、振幅、相位
[Re0,Im0,ab0,ang0]=furo(theta_0);
[Re1,Im1,ab1,ang1]=furo(theta_01);
[Re2,Im2,ab2,ang2]=furo(theta_001);
[Re3,Im3,ab3,ang3]=furo(theta_0001);

%% 对比振幅
ab=[ab0(128),ab1(128),ab2(128),ab3(128)];