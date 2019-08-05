close all

scat1 = Wireless431(100,1800,4,2,1,50);
scat2 = Wireless431(150,1800,4,2,1,50);
scat3 = Wireless431(50,1800,4,2,1,50);
scat4 = Wireless431(200,1800,4,2,1,50);

x1 = zeros(50,1);
for i = 1:50
    x1(i) = 100;
end
x2 = zeros(50,1);
for i = 1:50
    x2(i) = 150;
end
x3 = zeros(50,1);
for i = 1:50
    x3(i) = 50;
end
x4 = zeros(50,1);
for i = 1:50
    x4(i) = 200;
end

hold on
% axis([0 250 250 0])
scatter(log10(x1),scat1)
scatter(log10(x2),scat2)
scatter(log10(x3),scat3)
scatter(log10(x4),scat4)