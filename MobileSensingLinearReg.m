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

figure(1)
for i=1:4
    if y(i) == 1
        scatter(x(i,1),x(i,2),'r')
        hold on
    else    
        scatter(x(i,1),x(i,2),'b')
        hold on
    end
end
axis([-1 4 -1 4])
% plot([0,3.5],[3.5,0])

px = inv(x'*x)*x';
w = px*y;

sign1 = sign(w'*x(1,:)');
sign2 = sign(w'*x(2,:)');
sign3 = sign(w'*x(3,:)');
sign4 = sign(w'*x(4,:)');
sign = [sign1;sign2;sign3;sign4];

Ein1 = 1/4*(w'*x(1,:)'-y).^2;
Ein2 = 1/4*(w'*x(2,:)'-y).^2;
Ein3 = 1/4*(w'*x(3,:)'-y).^2;
Ein4 = 1/4*(w'*x(4,:)'-y).^2;
Ein = Ein1 + Ein2 + Ein3 + Ein4;