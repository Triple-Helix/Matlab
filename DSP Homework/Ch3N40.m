n = [-20:20];
n = n';
x1 = (1/4).^n .* unitstep(-20,0,20);
x2 = (1/3).^n .* unitstep(-20,0,20);
y  = 5 * (3/4).^n .* unitstep(-20,0,20);

x1z = ztrans(x1);
x2z = ztrans(x1);
yz  = ztrans(y);

h1z = yz./x1z;
h2z = yz./x2z;

h1 = iztranns(h1z);
h2 = iztranns(h2z);

plot(h1,-20,20,'b');
hold off
figure
plot(h2,-20,20,'b');