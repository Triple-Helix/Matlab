%Part A
n = [-20:20];
n = n';
d1 = delta(-20,-1,20);
u1 = unitstep(-20,-5,20);
u2 = unitstep(-20,4,20);
u3 = unitstep(-20,4,20);
u4 = unitstep(-20,8,20);
x1 = 5.*d1+n^2.*(u1-u2)+10*((.5)^n).*(u3-u4);
stem(-20:20,x1,'fill');