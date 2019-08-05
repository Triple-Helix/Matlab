n = [0:1:50];
ha = [1,-2,3,-4,0,4,-3,2,-1];
hc = [1/9,2/9,3/9,2/9,1/9];
hd = [1,-1.1756,1];
x = sin(.1.*pi.*n)+1/3.*sin(.3.*pi.*n)+1/5.*sin(.5.*pi.*n);

ya = conv(ha,x);
yc = conv(hc,x);
yd = conv(hd,x);

figure(1)
stem(x,'fill')
title('Problem 30 x')

figure(2)
stem(ya,'fill');
title('Problem 30 Part A')

figure(3)
stem(yc,'fill');
title('Problem 30 Part C')

figure(4)
stem(yd,'fill');
title('Problem 30 Part D')