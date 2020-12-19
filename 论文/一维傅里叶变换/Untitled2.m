for i=1:nViews
    ff(i)=252.8+82.08*cos(i*0.8881)+87.84*sin(i*0.8881);
end
plot(ff)