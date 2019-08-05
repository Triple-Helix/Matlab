clear all
close all
load('HW2-data.mat');

[numRows, numCols] = size(X);
colX1 = X(:,1);
colX2 = X(:,2);

%% K-Means Clustering
x = 0;
y = numRows;
r1 = 1;
r2 = 1;
while r1==r2
    r1 = floor((y-x).*rand(1,1) + x);
    r2 = floor((y-x).*rand(1,1) + x);
end

% initial random means
m1 = [X(r1,1) X(r1,2)];
m2 = [X(r2,1) X(r2,2)];

output = zeros(numRows,1);
output1 = ones(numRows,1);
iter = 1;

while 1
    m1Count = 0;
    m2Count = 0;
    for i=1:numRows
        dist1 = sqrt((X(i,1)-m1(1,1))^2+(X(i,2)-m1(1,2))^2);
        dist2 = sqrt((X(i,1)-m2(1,1))^2+(X(i,2)-m2(1,2))^2);
        if dist1>=dist2
            output1(i) = 1;
        else
            output1(i) = 2;
        end
    end
    
    % Make new mean vaules
    for j=1:numRows
        if output1(j) == 1;
            m1 = [X(j,1) X(j,2)]+m1;
            m1Count = m1Count+1;
        elseif output1(j) == 2;
            m2 = [X(j,1) X(j,2)] + m2;
            m2Count = m2Count+1;
        end
    end
    m1 = m1/m1Count;
    m2 = m2/m2Count;
    iter = iter +1;
    
    if output == output1
        break;
    elseif iter == 20
        break;
    end
    output = output1;
end

a = 1;
b = 1;

for k=1:numRows
    if output(k) == 1
        outCol1(a,1) = X(k,1) ;
        outCol1(a,2) = X(k,2);
        a=a+1;
    end
end
for l=1:numRows
    if output(l) == 2
        outCol2(b,1) = X(l,1);
        outCol2(b,2) = X(l,2);
        b=b+1;
    end
end

figure(1)
scatter(outCol1(:,1),outCol1(:,end),'r','fill')
hold on;
scatter(outCol2(:,1),outCol2(:,end),'b','fill')
xlabel('F1')
ylabel('F2')
title('K-Means Clustering')