z = [-20:1:20];
h = (1+5.6569.*z.^-1+16.*z.^-2)./(1-.8.*z.^-1+.64.*z.^-2);
hapnum = ((z.^-1+(1+i))./(4.*(2).^(1./2)).*((z.^-1+(1-i))./(4.*(2)^(1/2))));
hapdem = (z.^-1+4.*sqrt(2)./(1+i)).*(z.^-1+4.*sqrt(2)/(1-i));
hap = hapnum./hapdem;
hminnum = hapdem;
hmindem = (z.^-1+5./8.*(1-i.*sqrt(2))).*(z.^-1+5/8.*(1+i.*sqrt(2)));
hmin = hminnum./hmindem;

figure(1)
title('Problem 42')
stem(z,h,'fill','g');
hold on
stem(z,hap,'fill','r');
hold on 
stem(z,hmin,'fill','');b