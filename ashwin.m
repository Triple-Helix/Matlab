%% Ashwin K-means
load('HW2-data.mat');
[numRows, numCols] = size(X);
idx = kmeans(X,2)

for a=1:numRows
    if idx(a) == 1
        out1(a,1) = X(a,1) ;
        out1(a,2) = X(a,2);
        a=a+1;
    end
end
for b=1:numRows
    if idx(b) == 2
        out2(b,1) = X(b,1);
        out2(b,2) = X(b,2);
        b=b+1;
    end
end

figure(1)
scatter(out1(:,1),out1(:,2),'y')
hold on;
scatter(out2(:,1),out2(:,2),'r')