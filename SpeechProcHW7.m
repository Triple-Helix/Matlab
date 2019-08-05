% The Neural Responses of the 30 sentences by the 6 different neurons
[d1,w1] = NeuralResp(1);
[d2,w2] = NeuralResp(2);
[d3,w3] = NeuralResp(3);
[d4,w4] = NeuralResp(4);
[d5,w5] = NeuralResp(5);
[d6,w6] = NeuralResp(6);

maleIndex = [1,3,5,6,10,12,13,16,17,20,21,24,26,28,30];
femaleIndex = [2,4,7,8,9,11,14,15,18,19,22,23,25,27,29];

%% Neuron 1
maleData1 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = maleIndex
            maleData1(i,j) = d1(k,j);
        end
    end
end
catMaleData1 = zeros(1,4500);
for i = 1:15
    catMaleData1 = reshape(maleData1,[1,4500]);
end
meanMaleData1 = mean(catMaleData1);
figure
subplot(2,1,1); hist(catMaleData1);
title('Male Neuron 1');

femaleData1 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = femaleIndex
            femaleData1(i,j) = d1(k,j);
        end
    end
end
catFemaleData1 = zeros(1,4500);
for i = 1:15
    catFemaleData1 = reshape(femaleData1,[1,4500]);
end
meanFemaleData1 = mean(catFemaleData1);
subplot(2,1,2); hist(catFemaleData1);
title('Female Neuron 1');

figure
subplot(2,1,1); plot(w1(1,:))
title('waveform')
subplot(2,1,2); plot(d1(1,:))
title('data');
%% Neuron 2
maleData2 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = maleIndex
            maleData2(i,j) = d2(k,j);
        end
    end
end
catMaleData2 = zeros(1,4500);
for i = 1:15
    catMaleData2 = reshape(maleData2,[1,4500]);
end
meanMaleData2 = mean(catMaleData2);
figure
subplot(2,1,1); hist(catMaleData2);
title('Male Neuron 2');

femaleData2 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = femaleIndex
            femaleData2(i,j) = d2(k,j);
        end
    end
end
catFemaleData2 = zeros(1,4500);
for i = 1:15
    catFemaleData2 = reshape(femaleData2,[1,4500]);
end
meanFemaleData2 = mean(catFemaleData2);
subplot(2,1,2); hist(catFemaleData2);
title('Female Neuron 2');

figure
subplot(2,1,1); plot(w2(1,:))
title('waveform')
subplot(2,1,2); plot(d2(1,:))
title('data');
%% Neuron 3
maleData3 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = maleIndex
            maleData3(i,j) = d3(k,j);
        end
    end
end
catMaleData3 = zeros(1,4500);
for i = 1:15
    catMaleData3 = reshape(maleData3,[1,4500]);
end
meanMaleData3 = mean(catMaleData3);
figure
subplot(2,1,1); hist(catMaleData3);
title('Male Neuron 3');

femaleData3 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = femaleIndex
            femaleData3(i,j) = d3(k,j);
        end
    end
end
catFemaleData3 = zeros(1,4500);
for i = 1:15
    catFemaleData3 = reshape(femaleData3,[1,4500]);
end
meanFemaleData3 = mean(catFemaleData3);
subplot(2,1,2); hist(catFemaleData3);
title('Female Neuron 3');

figure
subplot(2,1,1); plot(w3(1,:))
title('waveform')
subplot(2,1,2); plot(d3(1,:))
title('data');
%% Neuron 4
maleData4 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = maleIndex
            maleData4(i,j) = d4(k,j);
        end
    end
end
catMaleData4 = zeros(1,4500);
for i = 1:15
    catMaleData4 = reshape(maleData4,[1,4500]);
end
meanMaleData4 = mean(catMaleData4);
figure
subplot(2,1,1); hist(catMaleData4);
title('Male Neuron 3');

femaleData4 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = femaleIndex
            femaleData4(i,j) = d4(k,j);
        end
    end
end
catFemaleData4 = zeros(1,4500);
for i = 1:15
    catFemaleData4 = reshape(femaleData4,[1,4500]);
end
meanFemaleData4 = mean(catFemaleData4);
subplot(2,1,2); hist(catFemaleData4);
title('Female Neuron 4');

figure
subplot(2,1,1); plot(w4(1,:))
title('waveform')
subplot(2,1,2); plot(d4(1,:))
title('data');
%% Neuron 5
maleData5 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = maleIndex
            maleData5(i,j) = d5(k,j);
        end
    end
end
catMaleData5 = zeros(1,4500);
for i = 1:15
    catMaleData5 = reshape(maleData5,[1,4500]);
end
meanMaleData5 = mean(catMaleData5);
figure
subplot(2,1,1); hist(catMaleData5);
title('Male Neuron 5');

femaleData5 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = femaleIndex
            femaleData5(i,j) = d5(k,j);
        end
    end
end
catFemaleData5 = zeros(1,4500);
for i = 1:15
    catFemaleData5 = reshape(femaleData3,[1,4500]);
end
meanFemaleData5 = mean(catFemaleData5);
subplot(2,1,2); hist(catFemaleData5);
title('Female Neuron 5');

figure
subplot(2,1,1); plot(w5(1,:))
title('waveform')
subplot(2,1,2); plot(d5(1,:))
title('data');
%% Neuron 6
maleData6 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = maleIndex
            maleData6(i,j) = d6(k,j);
        end
    end
end
catMaleData6 = zeros(1,4500);
for i = 1:15
    catMaleData6 = reshape(maleData6,[1,4500]);
end
meanMaleData6 = mean(catMaleData6);
figure
subplot(2,1,1); hist(catMaleData6);
title('Male Neuron 6');

femaleData6 = zeros(15,300);
for i = 1:15
    for j = 1:300
        for k = femaleIndex
            femaleData6(i,j) = d6(k,j);
        end
    end
end
catFemaleData6 = zeros(1,4500);
for i = 1:15
    catFemaleData6 = reshape(femaleData6,[1,4500]);
end
meanFemaleData6 = mean(catFemaleData6);
subplot(2,1,2); hist(catFemaleData6);
title('Female Neuron 6');

figure
subplot(2,1,1); plot(w3(1,:))
title('waveform')
subplot(2,1,2); plot(d3(1,:))
title('data');

%% Perform LDA 
maleMatrix = [catMaleData1; 
              catMaleData2;
              catMaleData3;
              catMaleData4;
              catMaleData5;
              catMaleData6];
covMale1 = cov(catMaleData1);
covMale2 = cov(catMaleData2);
covMale3 = cov(catMaleData3);
covMale4 = cov(catMaleData4);
covMale5 = cov(catMaleData5);
covMale6 = cov(catMaleData6);

femaleMatrix = [catFemaleData1;
                catFemaleData2;
                catFemaleData3;
                catFemaleData4;
                catFemaleData5;
                catFemaleData6];
covFemale1 = cov(catFemaleData1);
covFemale2 = cov(catFemaleData2);
covFemale3 = cov(catFemaleData3);
covFemale4 = cov(catFemaleData4);
covFemale5 = cov(catFemaleData5);
covFemale6 = cov(catFemaleData6);

% within class scatter
Sw1 = covMale1+covFemale1;
Sw2 = covMale2+covFemale2;
Sw3 = covMale3+covFemale3;
Sw4 = covMale4+covFemale4;
Sw5 = covMale5+covFemale5;
Sw6 = covMale6+covFemale6;

% between class scatter
Sb1 = (meanMaleData1-meanFemaleData1)'*(meanMaleData1-meanFemaleData1);
Sb2 = (meanMaleData2-meanFemaleData2)'*(meanMaleData2-meanFemaleData2);
Sb3 = (meanMaleData3-meanFemaleData3)'*(meanMaleData3-meanFemaleData3);
Sb4 = (meanMaleData4-meanFemaleData4)'*(meanMaleData4-meanFemaleData4);
Sb5 = (meanMaleData5-meanFemaleData5)'*(meanMaleData5-meanFemaleData5);
Sb6 = (meanMaleData6-meanFemaleData6)'*(meanMaleData6-meanFemaleData6);

% target matrix of LDA
J1 = Sb1*inv(Sw1);
J2 = Sb2*inv(Sw2);
J3 = Sb3*inv(Sw3);
J4 = Sb4*inv(Sw4);
J5 = Sb5*inv(Sw5);
J6 = Sb6*inv(Sw6);

[~,S1,V1] = svd(J1);
[~,S2,V2] = svd(J2);
[~,S3,V3] = svd(J3);
[~,S4,V4] = svd(J4);
[~,S5,V5] = svd(J5);
[~,S6,V6] = svd(J6);

% projected onto the new axis
projectMale1 = catMaleData1*V1;
projectMale2 = catMaleData2*V2;
projectMale3 = catMaleData3*V3;
projectMale4 = catMaleData4*V4;
projectMale5 = catMaleData5*V5;
projectMale6 = catMaleData6*V6;
projectFemale1 = catFemaleData1*V1;
projectFemale2 = catFemaleData2*V2;
projectFemale3 = catFemaleData3*V3;
projectFemale4 = catFemaleData4*V4;
projectFemale5 = catFemaleData5*V5;
projectFemale6 = catFemaleData6*V6;

figure
hist(projectMale1);
figure
hist(projectFemale1);
% Mean pairwise distance of points in two classes
classDist1 = mean2(pdist2(projectMale1(:,1),projectFemale1(:,2)));

figure
hist(projectMale2);
figure
hist(projectFemale2);
% Mean pairwise distance of points in two classes
classDist2 = mean2(pdist2(projectMale2(:,1),projectFemale2(:,2)));

figure
hist(projectMale3);
figure
hist(projectFemale3);
% Mean pairwise distance of points in two classes
classDist3 = mean2(pdist2(projectMale3(:,1),projectFemale3(:,2)));

figure
hist(projectMale4);
figure
hist(projectFemale4);
% Mean pairwise distance of points in two classes
classDist4 = mean2(pdist2(projectMale4(:,1),projectFemale4(:,2)));

figure
hist(projectMale5);
figure
hist(projectFemale5);
% Mean pairwise distance of points in two classes
classDist5 = mean2(pdist2(projectMale5(:,1),projectFemale5(:,2)));

figure
hist(projectMale6);
figure
hist(projectFemale6);
% Mean pairwise distance of points in two classes
classDist6 = mean2(pdist2(projectMale6(:,1),projectFemale6(:,2)));

%% Average Neural Response
for n = 1:6
    avgDataS  = AverageNeuralResp(n,'s');
    avgDataIH = AverageNeuralResp(n,'ih');
    avgDataAA = AverageNeuralResp(n,'aa');
    avgDataT  = AverageNeuralResp(n,'t');
    avgDataB  = AverageNeuralResp(n,'b');
    avgDataSH = AverageNeuralResp(n,'sh');

    meanDataS = mean(avgDataS);
    meanDataIH = mean(avgDataIH);
    meanDataAA = mean(avgDataAA);
    meanDataT = mean(avgDataT);
    meanDataB = mean(avgDataB);
    meanDataSH = mean(avgDataSH);

    figure
    subplot(2,3,1); hist(meanDataS); title('phoneme s');
    subplot(2,3,2); hist(meanDataIH); title('phoneme ih');
    subplot(2,3,3); hist(meanDataAA); title('phoneme aa');
    subplot(2,3,4); hist(meanDataT); title('phoneme t');
    subplot(2,3,5); hist(meanDataB); title('phoneme b');
    subplot(2,3,6); hist(meanDataSH); title('phoneme sh');
end