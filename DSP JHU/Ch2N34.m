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
hold off
figure(2)
stem(-20:20,b,'fill','b');