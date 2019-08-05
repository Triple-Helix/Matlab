clear all
close all

T = 1;

k1 = 1;
k2 = 2;
k3 = 3;
k4 = 4;
ind = 1;
for v = -50:1:20
    p1(ind) = exp(-v/T)*(v/T)^(k1-1)/factorial(k1-1);
    p2(ind) = exp(-v/T)*((v/T)^(k2-1)/factorial(k2-1)+(v/T)^(k1-1)/factorial(k1-1));
    p3(ind) = exp(-v/T)*((v/T)^(k3-1)/factorial(k3-1)+(v/T)^(k2-1)/factorial(k2-1)+(v/T)^(k1-1)/factorial(k1-1));
    p4(ind) = exp(-v/T)*((v/T)^(k4-1)/factorial(k4-1)+(v/T)^(k3-1)/factorial(k3-1)+(v/T)^(k2-1)/factorial(k2-1)+(v/T)^(k1-1)/factorial(k1-1));
    ind = ind+1;
end
hold on
v = -50:1:20
plot((v),-10*log10(p1));
plot((v),-10*log10(p2));
plot((v),-10*log10(p3));
plot((v),-10*log10(p4));