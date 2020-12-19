function [ F_uv ] = Fourier2D( f_xy,xy,uv )
%Fourier_uv 二维连续的傅立叶变换
%   f_xy 函数的符号表达式
%   xy 原函数域变量表示
%   uv 傅立叶域函数表示

if nargin==2
   syms u v
   uv=[u,v];    
end
    
F_uy=fourier(f_xy,xy(1),uv(1));
F_uv=fourier(F_uy,xy(2),uv(2));

end

