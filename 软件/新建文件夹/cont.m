% clc;
% clear;
b=ProjImg(:,:,1);
a=p_z(:,:,1);
a1=Rotate1(a,12,-0.3);
[ab,ang]=furo(b');
[ab0,ang0]=furo(a');
[ab1,ang1]=furo(a1');
zf=[ab(64),ab0(64),ab1(64)];
xw=[ang(64)*128/(2*pi),ang0(64)*128/(2*pi),ang1(64)*128/(2*pi)];




% for i=1:180
%     o=ProjImg(:,:,i);
% %     imshow(o,[]);
% %     title(['i=',num2str(i)]);
% %     pause(0.1);
%     [ab0,ang0]=furo(o');
%     ab(i)=ab0(64);
%     ang(i)=ang0(64);
% end
% plot(ab);
% figure
% plot(ang)

