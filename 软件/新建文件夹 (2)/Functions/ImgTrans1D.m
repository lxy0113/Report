function [ output_arr ] = ImgTrans1D( input_arr,mx )
%ImgTrans1D 对数组作平移
%   input_arr 输入数组
%   mx 平移量
%   output_arr 输出数组
if length(mx)>1
    mx=mx(1);
end



if mx==0
    output_arr=input_arr;
    % do nothing
else
    if mx>0
        output_arr=[zeros(1,mx),input_arr(1:end-mx)];
    else
        output_arr=[input_arr(-mx+1:end),zeros(1,-mx)];
    end
end











end

