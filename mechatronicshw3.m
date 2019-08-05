clear all
%Given Conditions
r = 1;
L = 1;

%Create t array
t = 0:.01:1;
deltaT = .01;

%Initialize Trajectory
for i=1:101
    x(i) = 5*exp(t(i));
    dx(i) = 5*exp(t(i));
    y(i) = 2*cos(t(i));
    dy(i) = -2*sin(t(i));
    theta(i) = 1/(t(i)+2);
    dTheta(i) = -1/(t(i)+2)^2;
end

%Calculate 3 Wheel Holonomic Drive Rotational Velocities
for m=1:3
    for i=1:101
        ThreedPhi(m,i) = -dx(i)*sin(theta(i) + 2*pi*(m-1)/3)+dy(i)*cos(theta(i) + 2*pi*(m-1)/3) + L*dTheta(i);
    end
end
for i=1:101
    ThreedPhi0(i) = ThreedPhi(1,i);
    ThreedPhi1(i) = ThreedPhi(2,i);
    ThreedPhi2(i) = ThreedPhi(3,i);
end

%Calculate 4 Wheel Holonomic Drive Rotational Velocities
for m=1:4
    for i=1:101
        FourdPhi(m,i) = -dx(i)*sin(theta(i) + pi*(m-1)/2)+dy(i)*cos(theta(i) + pi*(m-1)/2) + L*dTheta(i);
    end
end
for i=1:101
    FourdPhi0(i) = FourdPhi(1,i);
    FourdPhi1(i) = FourdPhi(2,i);
    FourdPhi2(i) = FourdPhi(3,i);
    FourdPhi3(i) = FourdPhi(4,i);
end

figure(1)
title('3 Wheel Rotational Velocity')
xlabel('dPhi')
ylabel('t')
hold on
plot(t, ThreedPhi0, 'r')
plot(t, ThreedPhi1, 'g')
plot(t, ThreedPhi2, 'b')
hold off

figure(2)
title('4 Wheel Rotational Velocity')
xlabel('dPhi')
ylabel('t')
hold on
plot(t, FourdPhi0, 'r')
plot(t, FourdPhi1, 'g')
plot(t, FourdPhi2, 'b')
plot(t, FourdPhi3, 'y')
hold off