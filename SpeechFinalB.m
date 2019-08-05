clear all
close all

s = SpeechCourse;
s = set(s,'subsets',[1,2,3,4]);
name = get(s, 'Names');
%% Extract F0 and F1 from SpeechCourse
formant = GetFeatures(s, 'aa', 'formant');
pitch = GetFeatures(s, 'aa', 'pitch');

[hgt, len] = size(formant); % size of formant and pitch are the same

F1 = zeros(len,1);
F0 = zeros(len,1);
% average the formant and pitch frequencies between StartTime and StopTime
for i = 1:len
    F1(i) = mean(formant(i).feat(:,1));
    F0(i) = mean(pitch(i).feat);
end
%% Set up D and L
fTrial = zeros(len,1);
pTrial = zeros(len,1);
for i=1:len
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
Di = [F0 F1];
D = mapstd(Di')'; % normalizes the data

% L represents the target matrix
L = zeros(len,1);
for i = 1:len
    if any(abs(fTrial(i)-maleIndex)<1e-10) % if the speaker is male
        L(i) = 1;
    else
        L(i) = 0;
    end
end

figure(8)
for i = 1:len
    if L(i) == 1
        hold on;
        scatter(F0(i),F1(i),'b','fill');
    else
        hold on;
        scatter(F0(i),F1(i),'r','fill');
    end
end
title('Male vs. Female Speakers');
xlabel('F0 (Hz)');
ylabel('F1 (Hz)');
%% Training

r = 2*rand(1,9)-1;
wi = [r(1), r(2); 
      r(3), r(4)];
wj = [r(5);
      r(6)];
bi = [r(7), r(8)];
bj = r(9);
% wi = 2*rand(2,2)-1; %uniformly distribution on [-1,1]
% wj = 2*rand(2,1)-1;
% bi = 2*rand(1,2)-1;
% bj = 2*rand(1,1)-1;

finalIter = 20;
errorVector = zeros(finalIter,1);

for iter = 1:finalIter;
    for cnt = 1:len;
        % Feed Forward
        zi = D(cnt,:)*wi+bi;
        yi = 1./(1+exp(-zi));
        zj = yi*wj+bj;
        yj = 1./(1+exp(-zj));
        
        % Back Propagation
        deltaj = (yj*(1-yj)*(yj-L(cnt,1)));
        bj = bj - deltaj;
        wj = wj - (yi'*deltaj);
        deltai = deltaj*wj.*(yi-(1-yi))';
        bi = bi - (deltai)';
        wi = wi - (D(cnt,:)'*deltai');
    end
    % Adjust new weights and calculate error
    layerOneSig = D*wi+repmat(bi,len,1);
    layerOneOut = 1./(1+exp(-layerOneSig));
    layerTwoSig = layerOneOut*wj+repmat(bj,len,1);
    layerTwoOut = 1./(1+exp(-layerTwoSig));
    errorVector(iter) = sum((layerTwoOut>0.5)~=L)/len;
end

%% Plot Error per Iteration 
figure(1);
plot(errorVector);
xlabel('Iteration');
ylabel('Error');
title('Output Error vs Iteration');

%% Scatter Output
figure(2);
title('Neural Network Feature Scatter Plot');
xlabel('F0 (Hz)');
ylabel('F1 (Hz)');
for i = 1:len
    if layerTwoOut(i) < .5
        hold on;
        scatter(F0(i),F1(i),'r','fill'); % red is female
    elseif layerTwoOut(i) >= .5
        hold on;
        scatter(F0(i),F1(i),'b','fill'); % blue is male
    end
end
%% K-means Clustering
r = floor(len*rand(2,1));
r1 = r(1)+1;
r2 = r(2)+1;

% initial random means
m1 = [F0(r1) F1(r1)];
m2 = [F0(r2) F1(r2)];

% output = zeros(len,1);
output1 = ones(len,1);
kcnt = 1;

errorVector2 = zeros(10,1);

while 1
    m1Count = 0;
    m2Count = 0;
    for i=1:len
        dist1 = sqrt((F0(i)-m1(1,1))^2+(F1(i)-m1(1,2))^2);
        dist2 = sqrt((F0(i)-m2(1,1))^2+(F1(i)-m2(1,2))^2);
        if dist1>=dist2
            output1(i) = 1;
        else
            output1(i) = 0;
        end
    end
    for j=1:len
        if output1(j) == 1;
            m1 = [F0(j) F1(j)] + m1;
            m1Count = m1Count+1;
        elseif output1(j) == 0;
            m2 = [F0(j) F1(j)] + m2;
            m2Count = m2Count+1;
        end
    end
    m1 = m1/m1Count;
    m2 = m2/m2Count;
    kcnt = kcnt+1;
    if kcnt == 10
        break;
    end
%     output = output1;
    
    errorVector2(kcnt) = sum((output1>0.5)~=L)/len;
    if errorVector2(kcnt) > .5
        errorVector2(kcnt) = 1-sum((output1>0.5)~=L)/len;
    end
end

errorVector2(1) = [];
if errorVector2(kcnt-1) == 0
    errorVector2(kcnt-1) = errorVector2(kcnt-2);
end

a = 1;
b = 1;

for k=1:len
    if output1(k) == 1
        outCol1(a,1) = F0(k);
        outCol1(a,2) = F1(k);
        a=a+1;
    elseif output1(k) == 0
        outCol2(b,1) = F0(k);
        outCol2(b,2) = F1(k);
        b=b+1;
    end
end
%% Calculate Error
figure(5)
plot(errorVector2);
title('Error per Iteration K-means clustering');
xlabel('Iteration');
ylabel('Error');

%% Scatter Output
figure(3);
scatter(outCol1(:,1),outCol1(:,end),'b','fill');
hold on;
scatter(outCol2(:,1),outCol2(:,end),'r','fill');
xlabel('F0 (Hz)');
ylabel('F1 (Hz)');
title('K-means Clustering Feature Scatter Plot');

%% Support Venctor Machine
figure(4)
svmStruct = svmtrain(Di,L,'ShowPlot',true);
title('Support Vector Machine');
xlabel('F0 (Hz)');
ylabel('F1 (Hz)');

svmModel = fitcsvm(Di,L,'Holdout',0.25,'Standardize',true);
testInds = test(svmModel.Partition);
CompactSVMModel = svmModel.Trained{1};
DTest = Di(testInds,:);
LTest = L(testInds,:);
svmError = loss(CompactSVMModel,DTest,LTest);
svmError2 = loss(CompactSVMModel,DTest,LTest,'LossFun','Hinge');