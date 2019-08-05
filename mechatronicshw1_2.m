L1 = 1;
L2 = 1;
tau = [0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1.0];
x = 1+tau/2;
y = 1+0.*tau;
deltax = .05;
deltay = 0;
deltaMatrix = [deltax; deltay];
theta1 = 0;
theta2 = 3.1415926/2;
jacobian = [0 0;0 0];
theta1RA = zeros(1, 11);
theta2RA = zeros(1, 11);

for i=1:11
    A = -L1*sin(theta1)-L2*sin(theta1+theta2);
    B = -L2*sin(theta1+theta2);
    C = L1*cos(theta1)+L2*cos(theta1+theta2);
    D = L2*cos(theta1+theta2);

    jacobian = [A B; C D];
    invJacob = inv(jacobian);
    deltaTheta = invJacob*deltaMatrix;
    deltatheta1 = deltaTheta(1);
    deltatheta2 = deltaTheta(2);
    theta1 = theta1 + deltatheta1;
    theta2 = theta2 + deltatheta2;
    theta1RA(i) = deltatheta1;
    theta2RA(i) = deltatheta2;
end