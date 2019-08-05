L1 = 1;
L2 = 1;
tau = [0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1.0];
x = 1+tau/2;
y = 1+0.*tau;
x2 = x.*x;
y2 = y.*y;

theta2 = acos((x2+y2-L1^2-L2^2)/(2*L1*L2));

phi = atan2(y,x);
xi = atan2(L2*sin(theta2),L1+L2*cos(theta2));
theta1 = (phi-xi);

disp(theta1*180/pi);
disp(theta2*180/pi);