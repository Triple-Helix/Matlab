%Find delay \alpha
corrM = zeros(1,100);
for n=1:100
delayD = delay(d,n);
corrM(n) = corr(s,delayD);
end

alpha = 9;
    d11 = delay(d,alpha);
    errorW = 0;
    for i = 1:2000
       errorW = errorW + (s(i)-d11(i))^2;
    end
    error(alpha) = errorW;