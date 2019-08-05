%               ----
%              - yj -
%               ----
%             v      v
%       wj11 v        v wj21              'j' layer
%           v          v
%        -----       -----
%       - yi1 -     - yi2 -
%        -----       -----
%         v    v  /     v
%    wi11 v     v/      v wi22            'i' layer
%         v     /v      v
%        ----  /  v   ----
%       - x1 -       - x2 -
%        ----         ----
%   cross weights are wi12 and wi21 respectively

clear all
close all
load('formantdata.mat')

[height, width] = size(D);

x1 = D(:,1);
x2 = D(:,end);

%----------------- Neural Network with Back Propogation -----------------%
iter = 1;
finalIter = 50;
index2 = height;
yj = zeros(index2,1);

error = zeros(finalIter-1,1);

% Initialize Random Weights
a = -5;
b = 5;
r = (b-a).*rand(6,1) + a;
wi11 = r(1);
wi12 = r(2);
wi21 = r(3);
wi22 = r(4);
wj11 = r(5);
wj21 = r(6);

while iter < finalIter
    for index1 = 1:index2
        % Calculate Hidden Layer outputs
        zi1 = x1(index1) * wi11 + x2(index1) * wi21; % input going into yi1
        zi2 = x1(index1) * wi12 + x2(index1) * wi22; % input going into yi2

        yi1 = 1/(1+exp(-zi1)); 
        yi2 = 1/(1+exp(-zi2));

        % Calculate Final Output
        zj = yi1 * wj11 + yi2 * wj21; % input going into yj
        yj(index1) = 1/(1+exp(-zj));  % the final output
        
        % Calculate square difference between output and target
        squareDiff(index1) = (yj(index1) - L(index1))^2;
        
        % Calculate weight corrections in top layer
        dEdyj = -(L(index1)-yj(index1));
        dEdzj = yj(index1)*(1-yj(index1)) * dEdyj;

        deltawj11 = dEdzj * yi1;
        deltawj21 = dEdzj * yi2;

        wj11 = wj11 - deltawj11;
        wj21 = wj21 - deltawj21;

        % Back Propogation to adjust weights between input and hidden layer
        dEdyi1 = wj11 * dEdyj;
        dEdyi2 = wj21 * dEdyj;
        dEdzi1 = dEdyi1 * yi1*(1-yi1);
        dEdzi2 = dEdyi2 * yi2*(1-yi2);

        deltawi11 = dEdzi1 * x1(index1);
        deltawi12 = dEdzi2 * x1(index1);
        deltawi21 = dEdzi1 * x2(index1);
        deltawi22 = dEdzi2 * x2(index1);

        wi11 = wi11 - deltawi11;
        wi12 = wi12 - deltawi12;
        wi21 = wi21 - deltawi21;
        wi22 = wi22 - deltawi22;
    end
    
    % Calculate error per iteration
    error(iter) = mean(squareDiff);
    
    % Advance the iteration
    iter = iter+1;
end

figure (1)
plot(error)
title('Error per Iteration');
ylabel('Error')
xlabel('Iteration')

figure(2)
title('Feature Scatter Plot')
xlabel('F1')
ylabel('F2')
for i = 1:index2
    if yj(i) < .5
        hold on
        scatter(x1(i),x2(i),'r','fill')
    elseif yj(i) >= .5
        hold on
        scatter(x1(i),x2(i),'b','fill')
    end
end