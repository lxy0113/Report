function [orth]=projection(image,X,Y,Rx,Ry,theta)
Xray=Rx.*cosd(theta)+Ry.*sind(theta);
Yray=-Rx.*sind(theta)+Ry.*cosd(theta);
orth=interp2(X,Y,image,Xray,Yray,'linear',0);
orth=sum(orth);
end