clear all
close all

s = SpeechCourse;
s = set(s,'subsets',[1,2,3,4]);
name = get(s, 'Names');
%% Extract F0 and F1 from SpeechCourse
formant = GetFeatures(s, 'ae', 'formant');
pitch = GetFeatures(s, 'ae', 'pitch');

[height, length] = size(formant); % size of formant and pitch are the same

F1 = zeros(length,1);
F0 = zeros(length,1);
% average the formant and pitch frequencies between StartTime and StopTime
for i = 1:length
    F1(i) = mean(formant(i).feat(:,1));
    F0(i) = mean(pitch(i).feat);
end
%% Set up D and L
fTrial = zeros(length,1);
pTrial = zeros(length,1);
for i=1:length
    fTrial(i) = formant(i).Trial;
    pTrial(i) = pitch(i).Trial;
end

% Gender index of all speakers in SpeechCourse object
[l, h] = size(name);
maleInd = 1;
femInd = 1;
for j=1:h
    if strncmp(name(1),name(j),1)
        maleIndex(maleInd) = j;
        maleInd = maleInd+1;
    else
        femaleIndex(femInd) = j;
        femInd = femInd+1;
    end
end

% D represents test matrix
D = [F0 F1];
D = mapstd(D')'; % normalizes the data

% L represents the target matrix
L = zeros(length,1);
for i = 1:length
    if any(abs(fTrial(i)-maleIndex)<1e-10) % if the speaker is male
        L(i) = 1;
    else
        L(i) = 0;
    end
end
%% Implement Neural Network
iter = 1;
finalIter = 100;
yj = zeros(length,1);
squareDiff = zeros(length,1);
error = zeros(length,1);

% Initialize Random Weights
r = 2.*rand(6,1)-1;
wi11 = r(1);
wi12 = r(2);
wi21 = r(3);
wi22 = r(4);
wj11 = r(5);
wj21 = r(6);

while iter < finalIter
    for index1 = 1:length
        % Calculate Hidden Layer outputs
        zi1 = F0(index1) * wi11 + F1(index1) * wi21; % input going into yi1
        zi2 = F0(index1) * wi12 + F1(index1) * wi22; % input going into yi2

        yi1 = 1/(1+exp(-zi1)); 
        yi2 = 1/(1+exp(-zi2));

        % Calculate Final Output
        zj = yi1 * wj11 + yi2 * wj21; % input going into yj
        yj(index1) = 1/(1+exp(-zj));  % the final output
                
        % Calculate weight corrections
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

        deltawi11 = dEdzi1 * F0(index1);
        deltawi12 = dEdzi2 * F0(index1);
        deltawi21 = dEdzi1 * F1(index1);
        deltawi22 = dEdzi2 * F1(index1);

        wi11 = wi11 - deltawi11;
        wi12 = wi12 - deltawi12;
        wi21 = wi21 - deltawi21;
        wi22 = wi22 - deltawi22;
    end
    
    % Advance the iteration
    iter = iter+1;
end

for i = 1:length
    if yj(i)<0 && L(i)==0
        error(i) = 0;
    elseif yj(i)>0 && L(i)==1
        error(i) = 0;
    else
        error(i) = 1;
    end
end

figure (1)
plot(error)
title('Error per Iteration');
ylabel('Error')
xlabel('Iteration')

figure(2)
title('Feature Scatter Plot')
xlabel('F0')
ylabel('F1')
for i = 1:length
    if yj(i) < .5
        hold on
        scatter(F0(i),F1(i),'r','fill')
    elseif yj(i) > .5
        hold on
        scatter(F0(i),F1(i),'b','fill')
    end
end