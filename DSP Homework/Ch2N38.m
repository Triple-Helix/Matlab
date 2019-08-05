%Part A
n1 = [-20:20];
n1 = n1';
d1 = delta(-20,-1,20);
u1 = unitstep(-20,-5,20);
u2 = unitstep(-20,4,20);
u3 = unitstep(-20,4,20);
u4 = unitstep(-20,8,20);

figure
x1 = 5.*d1+n1.^2.*(u1-u2)+10*((.5).^n1).*(u3-u4);
stem(-20:20,x1,'fill');

%Part B
n2 = [0:20];
n2 = n2';
pi = 3.1415926

figure
x2 = ((.8).^n2).*cos(.2*pi.*n2+pi/4);
stem(0:20,x2,'fill');

%Part C
n3 = [0:20];
n3 = n3';
x3 = 0;

figure
    for m = 0:1:4
    x3 = x3 + (m+1)*(delta(0,m,20)-delta(0,2*m,20));
    end
stem(0:20,x3,'fill');