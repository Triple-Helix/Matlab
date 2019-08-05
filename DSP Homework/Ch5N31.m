%Part B
nd = 0;
pi = 3.1415926535;
n = [-100:1:100];
hbp1 = 2.*((sin(pi./16.*(n-nd)).*cos(3.*pi.*n./16))./(pi.*(n-nd)));
hbp2 = 2.*((sin(pi./8.*(n-nd)).*cos(13.*pi.*n./16))./(pi.*(n-nd)));
hbp = hbp1 + hbp2;
figure (1)
stem(n,hbp,'fill');
title('Problem 31 Part B')
hold off

%Part C
w1 = [pi/8:pi/64:pi/4];
h1 = exp(-i.*w1.*nd);
w2 = [5*pi/8:pi/64:7*pi/4];
h2 = .5.*exp(-i.*w2.*nd);

figure (2)
stem(w1,h1,'fill','b');
title('Problem 31 Part C: H1')
stem(w2,h2,'fill','r');
title('Part C: H2')