clear all;
load('BP_readings.mat');

R1 = S4(:,1);
R2 = S4(:,2);

% get the bins
xl = min([R1;R2]);
xh = max([R1;R2]);
X = linspace(xl,xh,100);

% get counts in each bin
N1 = hist(R1,X);
N2 = hist(R2,X);
% counts to probs
P1 = N1/sum(N1);
P2 = N2/sum(N2);

figure;
plot(X,P1,'r');hold on;plot(X,P2);
legend('case-1','case-2');   

figure;
ax(1)=subplot(211);plot(X,P1,'r');grid on;
ax(2)=subplot(212);plot(X,P2);grid on;
linkaxes(ax,'x');



% ROC is defined as False positive rate vs True positive rate

FPR=zeros(100,1);
TPR=zeros(100,1);

for j = 1:length(X)
    FPR(j) = sum(P2(1:j));
    TPR(j) = sum(P1(1:j));
end

figure;
plot(FPR,TPR);hold on;plot([0 1],[0 1],'--');
legend('ROC for given data','ROC for random data','Location','SouthEast');
xlim([0 1]);ylim([0 1]);
xlabel('False postive rate');
ylabel('True postive rate');
