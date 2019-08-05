clear all

%Initialize values
a1 = 1;
a2 = 1;
b1 = 2; 
b2 = 2;
r = 1; 
w = 1;
vectorX0 = [0;0;0]; %Initial Position
vectorXd = [1;1;pi/4]; %Final Position

%Create t array
t = 0:.01:1;
t2 = t.*t;
deltaT = .01;

%Initialize Vector Arrays Paramteters
vectorA = [a1;a2];
vectorB = [b1;b2];
vectorC = [vectorA' vectorB']';

%Initial vectorFc
vectorFc = vectorX0;

iter = 1;

%While loop start
while norm(vectorXd-vectorFc)>=.1
    vectorFc = vectorX0;
    nextX = vectorX0;
    
    %Initialize Phi and d(Phi)/dt
    for i=1:100
        vectorPhi(:,i) = [0;0];
        dVectorPhi(:,i) = [0;0];
    end
    %Calculate Phi and d(Phi)/dt
    for i=1:100
        vectorPhi(:,i) = vectorA*t(i) + vectorB*t2(i);
        dVectorPhi(:,i) = vectorA + 2.*vectorB*t(i);
    end
    
    %dXVector Calculations
    for i=1:100
        A = [r/2*cos(nextX(3)) r/2*cos(nextX(3));
             r/2*sin(nextX(3)) r/2*sin(nextX(3));
             -r/w r/w];
        dVectorX = A*dVectorPhi(:,i);
        nextX = nextX + deltaT.*dVectorX;
    end
    vectorFc = vectorX0 + nextX;
    
    %Jacobian Calculations
    deltaVectorX = deltaT*(vectorXd - vectorFc)./norm(vectorXd - vectorFc);
    e  = [1;1;1;1];
    e1 = [1;0;0;0];
    e2 = [0;1;0;0];
    e3 = [0;0;1;1];
    e4 = [0;0;0;1];
    
    %Calculate dfdc1
    nextX = vectorX0;
    vectorA1 = vectorA + deltaT*[1;0];
    vectorB1 = vectorB + deltaT*[0;0];
    vectorC1 = vectorC + deltaT*e1;
    for i=1:100
        vectorPhi1(:,i) = vectorA1*t(i) + vectorB1*t2(i);
        dVectorPhi1(:,i) = vectorA1 + 2.*vectorB1*t(i);
    end
    for i=1:100
        A1 = [r/2*cos(nextX(3)) r/2*cos(nextX(3));
             r/2*sin(nextX(3)) r/2*sin(nextX(3));
             -r/w r/w];
        dVectorX1 = A1*dVectorPhi1(:,i);
        nextX = nextX + deltaT.*dVectorX1;
    end
    dVectorFc1 = vectorX0 + nextX;
    dfdc1 = (1./deltaT).*(dVectorFc1-vectorFc);

    %Calculate dfdc2
    nextX = vectorX0;
    vectorA2 = vectorA + deltaT*[0;1];
    vectorB2 = vectorB + deltaT*[0;0];
    vectorC2 = vectorC + deltaT*e2;
    for i=1:100
        vectorPhi2(:,i) = vectorA2*t(i) + vectorB2*t2(i);
        dVectorPhi2(:,i) = vectorA2 + 2.*vectorB2*t(i);
    end
    for i=1:100
        A2 = [r/2*cos(nextX(3)) r/2*cos(nextX(3));
             r/2*sin(nextX(3)) r/2*sin(nextX(3));
             -r/w r/w];
        dVectorX2 = A2*dVectorPhi2(:,i);
        nextX = nextX + deltaT.*dVectorX2;
    end
    dVectorFc2 = vectorX0 + nextX;
    dfdc2 = (1./deltaT).*(dVectorFc2-vectorFc);
    
    %Calculate dfdc3
    nextX = vectorX0;
    vectorA3 = vectorA + deltaT*[0;0];
    vectorB3 = vectorB + deltaT*[1;0];
    vectorC3 = vectorC + deltaT*e3;
    for i=1:100
        vectorPhi3(:,i) = vectorA3*t(i) + vectorB3*t2(i);
        dVectorPhi3(:,i) = vectorA3 + 2.*vectorB3*t(i);
    end
    for i=1:100
        A3 = [r/2*cos(nextX(3)) r/2*cos(nextX(3));
             r/2*sin(nextX(3)) r/2*sin(nextX(3));
             -r/w r/w];
        dVectorX3 = A3*dVectorPhi3(:,i);
        nextX = nextX + deltaT.*dVectorX3;
    end
    dVectorFc3 = vectorX0 + nextX;
    dfdc3 = (1./deltaT).*(dVectorFc3-vectorFc);
    
    %Calculate dfdc4
    nextX = vectorX0;
    vectorA4 = vectorA + deltaT*[0;0];
    vectorB4 = vectorB + deltaT*[0;1];
    vectorC4 = vectorC + deltaT*e4;
    for i=1:100
        vectorPhi4(:,i) = vectorA4*t(i) + vectorB4*t2(i);
        dVectorPhi4(:,i) = vectorA4 + 2.*vectorB4*t(i);
    end
    for i=1:100
        A4 = [r/2*cos(nextX(3)) r/2*cos(nextX(3));
             r/2*sin(nextX(3)) r/2*sin(nextX(3));
             -r/w r/w];
        dVectorX4 = A4*dVectorPhi4(:,i);
        nextX = nextX + deltaT.*dVectorX4;
    end
    dVectorFc4 = vectorX0 + nextX;
    dfdc4 = (1./deltaT).*(dVectorFc4-vectorFc);
    
    %Put it all together in the Jacobian
    J = [dfdc1 dfdc2 dfdc3 dfdc4];
    %Calculate deltaVectorC
    deltaVectorC = J'*inv(J*J')*deltaVectorX;
    %Update vectorC
    vectorC = vectorC + deltaVectorC;
    vectorA = [vectorC(1);vectorC(2)];
    vectorB = [vectorC(3);vectorC(4)];
    
    vectorFcRA(:, :, iter) = vectorFc; 
    dVectorXRA(:, :, iter) = dVectorX; 
    
    iter = iter +1;
end

%Display Final Results
disp('vectorC: ');
disp(vectorC); %Final a1, a2, a3, and a4 values
disp('Final Position and Orientation: ');
disp(vectorFc); %Final Position and Orientation

%Plot the Trajectories
numPoints = length(vectorFcRA);
figure(1)
for i = 1:floor((numPoints)/20):numPoints
      trajectories = vectorFcRA(:, :, i);
      x = [trajectories(1), trajectories(1) + 0.1*sin(trajectories(3))];
      y = [trajectories(2), trajectories(2) + 0.1*cos(trajectories(3))];
      plot(x, y);
end
trajectories = vectorFcRA(:,:, numPoints);
x = [trajectories(1), trajectories(1) + 0.1*sin(trajectories(3))];
y = [trajectories(2), trajectories(2) + 0.1*cos(trajectories(3))];
plot(x, y);