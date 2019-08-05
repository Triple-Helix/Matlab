clear all
close all

% Points
x = zeros(3,2)
x(1,:,:) = [0,2];
x(2,:,:) = [3,1];
x(3,:,:) = [2,1];
x(4,:,:) = [2,2];

% Labels
y = zeros(4,1);
y(1) = 1;
y(2) = -1;
y(3) = 1;
y(4) = -1;

SVMModel = fitcsvm(x,y);
sv = SVMModel.SupportVectors;

figure
gscatter(x(:,1),x(:,2),y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('-1','1','Support Vector')
hold off