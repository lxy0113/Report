function [orth]=proj3D(image,X,Y,Z,Rx,Ry,Rz,theta)
N=64;
Xray=Rx;
Yray=-Rz.*sind(theta)+Ry.*cosd(theta);
Zray=Rz.*cosd(theta)+Ry.*sind(theta);
% Xray=Rx.*cosd(theta)+Ry.*sind(theta);
% Yray=-Rx.*sind(theta)+Ry.*cosd(theta);
% Zray=Rz;
% Xray=Rx.*cosd(theta)+Rz.*sind(theta);
% Yray=Ry;
% Zray=-Rx.*sind(theta)+Rz.*cosd(theta);
orth=interp3(X,Y,Z,image,Xray,Yray,Zray,'linear',0);
orth=sum(orth);
% c=zeros(N,N);
% for i=1:N
%     for j=1:N
%         c(i,j)=sum(orth(i,j,z));
%     end
% end
% orth=0;
end