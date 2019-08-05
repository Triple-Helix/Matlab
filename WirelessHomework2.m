clear all
close all

Pt = 100;
Gr = 1; Gt = 1;
hr = 3; ht = 49;
d = 1:50;
w = 1800*10^6;
PrAprx = Pt*Gt*Gr*hr^2*ht^2./(d.*d.*d.*d);

theta = 2*ht*hr./d.^2;
PrExct = Pt*Gt*Gr*hr^2*ht^2./(d.*d.*16*pi^2).*(2-2.*cos(theta));

hold on
plot(20*log(PrExct));
plot(20*log(PrAprx));