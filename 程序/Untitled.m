%% theta±ä»¯
load proj_2;
load proj_90;
load proj_901;
load proj_1;


a1= proj_1;
a=proj_2;
b=proj_90;
c=proj_901;


[Re0,Im0,ab0,ang0]=furo(a1);
[Re1,Im1,ab1,ang1]=furo(a);
[Re2,Im2,ab2,ang2]=furo(b);
[Re3,Im3,ab3,ang3]=furo(c);


zf=[ab0(128),ab1(128),ab2(128),ab3(128)];
xw=[ang0(128),ang1(128),ang2(128),ang3(128)];