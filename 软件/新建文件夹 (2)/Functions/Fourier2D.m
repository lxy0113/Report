function [ F_uv ] = Fourier2D( f_xy,xy,uv )
%Fourier_uv ��ά�����ĸ���Ҷ�任
%   f_xy �����ķ��ű��ʽ
%   xy ԭ�����������ʾ
%   uv ����Ҷ������ʾ

if nargin==2
   syms u v
   uv=[u,v];    
end
    
F_uy=fourier(f_xy,xy(1),uv(1));
F_uv=fourier(F_uy,xy(2),uv(2));

end

