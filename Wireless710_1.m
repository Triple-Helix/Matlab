clear all 
close all

gDB1 = -40:19;
g1 = 10.^(gDB1/10);
g_m1 = zeros(1,60);

gDB2 = -40:19;
g2 = 10.^(gDB2/10);
g_m2 = zeros(1,60);

gDB3 = -40:19;
g3 = 10.^(gDB3/10);
g_m3 = zeros(1,60);

gDB4 = -40:19;
g4 = 10.^(gDB4/10);
g_m4 = zeros(1,60);

for i = 1:60
    T = 0;
    for k = 1:1
        T = T + ((g1(i))^(k-1))/factorial(k-1);
    end
    g_m1(i) = 1-exp(-g1(i))*T;   
end

for i = 1:60
    T = 0;
    for k = 1:2
        T = T + ((g2(i))^(k-1))/factorial(k-1);
    end
    g_m2(i) = 1-exp(-g2(i))*T;   
end

for i = 1:60
    T = 0;
    for k = 1:3
        T = T + ((g3(i))^(k-1))/factorial(k-1);
    end
    g_m3(i) = 1-exp(-g3(i))*T;   
end

for i = 1:60
    T = 0;
    for k = 1:4
        T = T + ((g4(i))^(k-1))/factorial(k-1);
    end
    g_m4(i) = 1-exp(-g4(i))*T;   
end

g_mDB1 = 10*log10(g_m1);
g_mDB2 = 10*log10(g_m2);
g_mDB3 = 10*log10(g_m3);
g_mDB4 = 10*log10(g_m4);

figure(1)
hold on
plot(gDB1, g_mDB1)
plot(gDB2, g_mDB2)
plot(gDB3, g_mDB3)
plot(gDB4, g_mDB4)
title('Probability Distribution of SNR for Maximal Ratio Combining');