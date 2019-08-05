load djw6576.txt;

x = djw6576';
x = [zeros(1,50) x];
x = [x zeros(1,50)];

y1 = [];
y2 = [];

n = 51
while n>50 && n<50+50+600+1
    t1 = x(n-50:n-0);
    a = sum(t1);
    y1 = [y1 a];
    n = n+1;
end

n=51
lb = -25
ub = 25
while n>25 && n<50+50+600+1-25
    while lb<25
        t2 = x(n-25);
        b = sum(t2);
        b = b + t2;
        lb = lb+1;
    end
    y2 = [y2 b];
    lb = -25;
    n = n+1;
    b=0
end

y1 = y1/51;
y2 = y2/51;


plot(x(51:651));
hold on
plot(y1(1:600),'r');
plot(y2(1:600),'b');