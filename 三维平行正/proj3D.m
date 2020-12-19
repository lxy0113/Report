function [orth]=proj3D(image,X,Y,Z,Rx,Ry,RZ,theta)
Xray=Rx.*cosd(theta)+Ry.*sind(theta);
Yray=-Rx.*sind(theta)+Ry.*cosd(theta);
Zray=RZ;
orth=interp3(X,Y,Z,image,Xray,Yray,Zray,'linear',0);
orth=sum(orth);
end