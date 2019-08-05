clear all
close all
load('formantdata.mat')

[numRowsD, numColsD] = size(D);

colD1 = D(:,1);
colD2 = D(:,end);

%--------------------- Linear Discriminant Analysis ---------------------%
classLabel = [0;1];
k = 2;

nGroup = NaN(k,1);                      % Group counts
groupMean = NaN(k,numColsD);            % Group sample means
pooledCov = zeros(numColsD,numColsD);   % Pooled covariance
W = NaN(k,numColsD+1);                  % model coefficients

for i = 1:k,
    % Establish location and size of each class
    group = (L == classLabel(i));
    nGroup(i) = sum(group);
    
    % Calculate group mean vectors
    groupMean(i,:) = mean(D(group,:));
    
    % Accumulate pooled covariance information
    pooledCov = pooledCov+((nGroup(i)-1)/(numRowsD-k)).*cov(D(group,:));
end

for j = 1:k,
    % Constant
    W(j,1) = -0.5*groupMean(j,:)/pooledCov*groupMean(j,:)';
    
    % Linear
    W(j,2:end) = groupMean(j,:)/pooledCov;
end

hist(W)