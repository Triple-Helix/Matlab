clear all
close all

sRate = 19.2e3;
BT1 = .5;
BT2 = .2;
BT3 = .75;

Ts = 1/sRate;
B1 = BT1/Ts;
B2 = BT2/Ts;
B3 = BT3/Ts;
alpha1 = sqrt(log(2))/(sqrt(2)*B1);
alpha2 = sqrt(log(2))/(sqrt(2)*B2);
alpha3 = sqrt(log(2))/(sqrt(2)*B3);

upper = 100000;

for f = 1:upper
    H1(f) = exp(-alpha1^2*(f-upper/2)^2);
    H2(f) = exp(-alpha2^2*(f-upper/2)^2);
    H3(f) = exp(-alpha3^2*(f-upper/2)^2);
end

upper1 = 2500;

for t = 1:upper1
    h1(t) = sqrt(pi)/alpha1 * exp(-pi^2/alpha1^2 * ((t-upper1/2)*alpha1/1000)^2);
    h2(t) = sqrt(pi)/alpha2 * exp(-pi^2/alpha2^2 * ((t-upper1/2)*alpha2/1000)^2);
    h3(t) = sqrt(pi)/alpha3 * exp(-pi^2/alpha3^2 * ((t-upper1/2)*alpha3/1000)^2);
end

x = 1:upper;
x = x-upper/2;

figure(1)
hold on
plot(x,H1,'r');
plot(x,H2,'g');
plot(x,H3);
title('Frequency Response H(f)');
hold off

x11 = 1:upper1;
x11 = (x11 - upper1/2)*alpha1;
x12 = 1:upper1;
x12 = (x12 - upper1/2)*alpha2;
x13 = 1:upper1;
x13 = (x13 - upper1/2)*alpha3;

figure(2)
hold on
plot(x11/1000,h1,'r');
plot(x12/1000,h2,'g');
plot(x13/1000,h3);
title('Impulse Response h(t)');
hold off