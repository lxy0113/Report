clear;
[x,y,z]=peaks(30);
[xq,yq] = meshgrid(-4:.2:4, -4:.2:4);
%% 插值会出现nan
vq = griddata(x,y,z,xq,yq);
%% 采用‘v4’方法插值没有nan
vq1 = griddata(x,y,z,xq,yq,'v4');
%% 可以查看一下vq和vq1进行对比，vq1没有nan。