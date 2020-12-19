function outcome = Rmse( data1,data2 )
%Rmse �����������ݵľ��������
% ע��
%1. ���������Ϊһ������ʱ������Ϊ��������������������֮��Ľ��
%2. data1,data2��Ҫ������ͬ��ά��
%3. �����������㹫ʽΪ 
%%
% $$ rmse=\sqrt{\sum_{i=1}^{N} \frac{{(data1_{(i)}-data2_{(i)})^2}}N} $$
% $$     =\sqrt{\sum_{i=1}^{N} \frac{{(dataerr_{(i)})^2}}N} $$

N=numel(data1);
Dsize=size(data1);
if nargin==1
    data_err=data1;
end

if nargin==2
    if(numel(data2)~=N)
        disp('��������ά�Ȳ�ƥ�䣡')
        outcome=0;
        return
    else
        data_err=data1-data2;
    end
end

if(length(Dsize)>2)
   outcome=sqrt(sum(sum(sum(data_err.^2)))/N);
else
   outcome=sqrt(sum(sum(data_err.^2))/N);
end










end

