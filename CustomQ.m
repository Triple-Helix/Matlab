function answer=CustomQ(x)
syms y;

answer = zeros(1,10);
for d = 400:410
    disp(d);
    answer(d-399)=(1/sqrt(72*pi))*int(exp(-(y+40*log(1600-d))^2/72),y,x,inf);
end
% answer=eval(answer);