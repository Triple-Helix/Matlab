a = .8;
b = 1.8;
pi = 3.1415926535;
w = [0:pi/8:pi];
n = [-20:1:20];
y1 = 3.*cos(pi.*n/2);
x1 = 3.*cos(pi.*n/2);
x2 = 3.*sin(pi.*n/4);
y2 = .469*sin(n.*pi/4+.6747);
h = b./(1+a.*exp(-2.*1i.*w));

figure (1)
stem(w,h);
title('Problem 24 Frequency Response');

figure (2)
stem(n,y1,'fill','r');
hold all
stem(n,x1,'fill','b');
title('Problem 24 y1');

figure (3)
stem(n,y2,'fill','r');
hold all
stem(n,x2,'fill','b');
title('Problem 24 y2');