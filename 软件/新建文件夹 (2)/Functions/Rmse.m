function outcome = Rmse( data1,data2 )
%Rmse 计算两个数据的均方根误差
% 注意
%1. 当输入参数为一个数据时，则认为该数据是两个数据作差之后的结果
%2. data1,data2需要保持相同的维度
%3. 均方根误差计算公式为 
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
        disp('两个数据维度不匹配！')
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

