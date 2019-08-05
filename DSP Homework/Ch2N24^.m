x = load('djw6576.txt');
y1 = 0;
for n1 = 0:1:600
    for k1 = 0:1:50
    y1 = y1 + 1/51 * x(n1-k1);
    end
end
y2 = 0
for n2 = 0:1:600
    for k2 = -25:1:25
    y2 = 1/51 * x(n2-k2);
    end
end