y = [1 .9 -.81];
x = [1];

%Part A
d = delta(-20,0,20);
a = filter(x,y,d);
figure
stem(-20:20,a,'fill','r');

%Part B
s = unitstep(-20,0,20);
b = filter(x,y,s);
hold on
figure
stem(-20:20,b,'fill','b');

%Part C
%Steady-State part goes from (-infinity,0). Transient part DNE