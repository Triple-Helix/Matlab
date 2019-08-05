clear all
close all
load('formantdata.mat')

[numRowsD, numColsD] = size(D);

colD1 = D(:,1);
colD2 = D(:,end);

%-------------------------- K-Means Clustering --------------------------%
% x = 0;
% y = numRowsD;
r1 = 100;
r2 = 350;
% while r1==r2
%     r1 = floor((y-x).*rand(1,1) + x);
%     r2 = floor((y-x).*rand(1,1) + x);
% end

% initial random means
m1 = [D(r1,1) D(r1,2)];
m2 = [D(r2,1) D(r2,2)];

output = zeros(numRowsD,1);
output1 = ones(numRowsD,1);

iter = 1;
a = 1;
b = 1;

while 1
    m1Count = 0;
    m2Count = 0;
    for i=1:numRowsD
        dist1 = sqrt((D(i,1)-m1(1,1))^2+(D(i,2)-m1(1,2))^2);
        dist2 = sqrt((D(i,1)-m2(1,1))^2+(D(i,2)-m2(1,2))^2);
        if dist1>=dist2
            output1(i) = 1;
        else
            output1(i) = 2;
        end
    end
    for j=1:numRowsD
        if output1(j) == 1;
            m1 = [D(j,1) D(j,2)]+m1;
            m1Count = m1Count+1;
        elseif output1(j) == 2;
            m2 = [D(j,1) D(j,2)] + m2;
            m2Count = m2Count+1;
        end
    end
    m1 = m1/m1Count;
    m2 = m2/m2Count;
    if output == output1
        break;
    elseif iter == numRowsD
        break;
    end
    output = output1;
    
    if output(iter) == 1
        outCol1(a,1) = D(iter,1) ;
        outCol1(a,2) = D(iter,2);
        a=a+1;
    end
    if output(iter) == 2
        outCol2(b,1) = D(iter,1);
        outCol2(b,2) = D(iter,2);
        b=b+1;
    end
    iter = iter+1;
end

figure(1)
scatter(outCol1(:,1),outCol1(:,end),'r','fill')
hold on;
scatter(outCol2(:,1),outCol2(:,end),'b','fill')
xlabel('F1')
ylabel('F2')