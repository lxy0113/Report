clear;
[x,y,z]=peaks(30);
[xq,yq] = meshgrid(-4:.2:4, -4:.2:4);
%% ��ֵ�����nan
vq = griddata(x,y,z,xq,yq);
%% ���á�v4��������ֵû��nan
vq1 = griddata(x,y,z,xq,yq,'v4');
%% ���Բ鿴һ��vq��vq1���жԱȣ�vq1û��nan��