clear all
close all
% % Test
% p = [.333; ...
%      .333; ...
%      .333];
% e = [.5,.5; ...
%      .333,.667; ...
%      .75,.25];
% t = [.3,.6,.1; ...
%      .5,.2,.3; ...
%      .4,.1,.5];

% NYC
p = [.4; ... % Sunny
     .3; ... % Cloudy
     .3];    % Rainy
%     H  U
e = [.9,.1; ... % Sunny
     .5,.5; ... % Cloudy
     .2,.8];    % Rainy
%   S+1 C+1 R+1 
t = [.7,.2,.1; ... % Sunny
     .3,.4,.3; ... % Cloudy
     .1,.2,.7];    % Rainy
 
% LA
% p = [.7; ... % Sunny
%      .2; ... % Cloudy
%      .1];    % Rainy
% %     H  U
% e = [.9,.1; ...
%      .5,.5; ...
%      .2,.8];
% %   S+1 C+1 R+1 
% t = [.7,.2,.1; ... % Sunny
%      .5,.3,.2; ... % Cloudy
%      .3,.3,.4];    % Rainy

%% Part 1: using Viterbi Algorithm assuming we live in NYC
% 1 is Happy, 0 is Unhappy
observation = [1 1 0 0 1 1 0 0 1 1 0 0];

% Compute Initial Viterbi weights
v = zeros(3,length(observation));
w = zeros(3,length(observation)+1);
path = zeros(1,length(observation));

w(1,1) = p(1);
w(2,1) = p(2);
w(3,1) = p(3);

for i = 1:length(observation)
    % Calculate Viterbi prob
    if observation(i) == 1 % Happy
        v(1,i) = w(1,i)*e(1,1);
        v(2,i) = w(2,i)*e(2,1);
        v(3,i) = w(3,i)*e(3,1);
    else % Unhappy
        v(1,i) = w(1,i)*e(1,2);
        v(2,i) = w(2,i)*e(2,2);
        v(3,i) = w(3,i)*e(3,2);
    end
    
    % Calculate new weights
    w(1,i+1) = max([ v(1,i)*t(1,1), ...
                     v(2,i)*t(2,1), ...
                     v(3,i)*t(3,1) ]);
    w(2,i+1) = max([ v(1,i)*t(1,2), ...
                     v(2,i)*t(2,2), ...
                     v(3,i)*t(3,2) ]);
    w(3,i+1) = max([ v(1,i)*t(1,3), ...
                     v(2,i)*t(2,3), ...
                     v(3,i)*t(3,3) ]);

    % Determine Path
    if max(v(:,i)) == v(1,i)
        path(i) = 1;
    elseif max(v(:,i)) == v(2,i)
        path(i) = 2;
    elseif max(v(:,i)) == v(3,i)
        path(i) = 3;
    end
end