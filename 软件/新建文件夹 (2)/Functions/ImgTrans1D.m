function [ output_arr ] = ImgTrans1D( input_arr,mx )
%ImgTrans1D ��������ƽ��
%   input_arr ��������
%   mx ƽ����
%   output_arr �������
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

