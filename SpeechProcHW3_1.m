clear all
close all
load('formantdata.mat')

[numRowsD, numColsD] = size(D);

colD1 = D(:,1);
colD2 = D(:,end);

%--------------------- Principal Component Analysis ---------------------%
[U,S,W] = svd(D); 
pc = -W;              % -(W) is the PC matrix
score = -U*S;            % -(U*S) is the score matrix

Cov = S(1,1)^2/(S(1,1)^2+S(2,2)^2);
% the first principal component accounts for 82.71% of the variance

figure(1)
biplot(pc(:,1:2),'Scores',score(:,1:2),'VarLabels', {'X1' 'X2'})
figure(2)
hist(pc);