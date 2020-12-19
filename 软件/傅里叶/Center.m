%% 求质心
function [c_x,c_y]=Center(I)
I=I';%可能
[N,M]=size(I);
s=sum(sum(I));
x=0;
y=0;
for i=1:N
    for j=1:N
        x=x+i*I(i,j);
        y=y+j*I(i,j);
    end
end
c_x=(x/s);
c_y=(y/s);
% c_x=round(x/s);
% c_y=round(y/s);
end