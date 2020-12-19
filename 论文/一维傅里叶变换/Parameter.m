%% 加探测器的跳动和摆动
function [m_x,m_y,theta_z,x,y,z]=Parameter(nviews,N)
if(N==128)
    x=2;y=2;z=1;%设置范围（m_x,m_y属于-10~10,间隔1；theta_z属于-1~1，间隔0.1）
end
if(N==256)
    x=5;y=5;z=1;%设置范围（m_x,m_y属于-10~10,间隔1；theta_z属于-1~1，间隔0.1）
end
if(N==512)
    x=10;y=10;z=1;%设置范围（m_x,m_y属于-10~10,间隔1；theta_z属于-1~1，间隔0.1）
end
m_x=0.00001*(round(rand(1,nviews)*2*x*10000))-x;%0~10的随机正整数
m_y=0.00001*(round(rand(1,nviews)*2*y*10000))-y;%0~10的随机正整数
theta_z=0.1*round(rand(1,nviews)*10*2*z)-z;%0~1，间隔0.1
%% 生成数据分布图
figure(1);
plot(m_x);
hold on;
plot(m_y);
xlabel('投影角度');
ylabel('像素');
title('端跳、径跳参数构造');
legend('端跳','径跳');
figure(3);
plot(theta_z);
xlabel('投影角度');
ylabel('摆角');
title('摆角参数构造');
end