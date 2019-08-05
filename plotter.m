clear all
close all

% Parametrs
% Field Dimensions
    xm = 15;
    ym = 15;
% Threshold Parameters
    % Clusterhead Probablity
    p = .05;
    
% Populate field with nodes
    xCoor = rand(xm,1)*10;
    yCoor = rand(ym,1)*10;

rmax = 1;
% rmax = 1/p-1; % Number of rounds
AllNodes = [xCoor yCoor];
G = [xCoor yCoor]; 

for r = 1:rmax
    CH = [0 0];
    NCH = [xCoor yCoor]; % reset Not Clusterhead list
    
    % Determine Clusterheads
    % Assign random numbers to each index in G
    CHcount = 0;
    CHindex = 0;
    [hei len] = size(G);
    Grand = rand(1,hei);
    % Threshold Function
    T(r) = p/(1-p*(mod(r,1/p)));
    for n = 1:hei
        if Grand(n) < T(r)
            CHcount = CHcount+1;
            CH(CHcount,:) = G(n,:);
            CHindex(CHcount) = n;
        end
    end
end

scatter(xCoor, yCoor,'k','fill');
title('Round:  ');