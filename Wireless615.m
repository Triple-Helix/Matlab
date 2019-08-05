clear all
close all

Ts = 1/24.3; % ks
alpha = .35;

h = zeros(1000,1);
for t = 1:1000
    h(t) = sinc((t-500)/1000/Ts)*(cos(pi*alpha*(t-500)/1000/Ts)/(1-4*alpha^2*((t-500)/1000)^2/Ts^2));
end

H = zeros(100,1);
for f = 1:100
    if abs(f-50)<=(1-alpha)/(2*Ts)
        H(f) = Ts;
    elseif abs(f-50)<=(1+alpha)/(2*Ts)
        H(f) = Ts/2 * (1+cos(pi*Ts/alpha*(abs(f-50)-(1-alpha)/(2*Ts))));
    end
end

figure(1)
x = 1:1000;
x = (x-500)/10e5;
plot(x,h)
title('Impulse Response h(t)')
xlabel('Time (s)')

figure(2)
X = 1:100;
X = (X-50)*1000;
plot(X,H/1000)
title('Frequency Response H(f)')
xlabel('Frequency (Hz)')