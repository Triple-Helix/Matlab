clear all

% Energy constants
    % Energy dissipated rinning Tx & Rx circuits
    Eelec = 50e-9; %nJ/bit
    % Energy dissipated from transmission amplifier
    Eamp = 100e-12; %pJ/bit/m^2
    % Path Loss
    lambda = 2;

% Calculate energy used to transmit/receive
CHcount = 4;
numNodes = 15;
% Worst Case round 1
% dist = [2.5 10 10 10;
%         4 10 10 10;
%         3.9 10 10 10;
%         6.5 10 10 10;
%         10 3.5 10 10;
%         10 5 10 10;
%         10 5.2 10 10;
%         10 10 2.6 10;
%         10 10 1.8 10;
%         10 10 2 10;
%         10 10 6.86 10;
%         10 10 9.25 10;
%        ];
% Best Case Round 1
dist = [1 10 10 10;
        3.53 10 10 10;
        3.35 10 10 10;
        10 .8 10 10;
        10 2.1 10 10;
        10 10 2 10;
        10 10 5 10;
        10 10 10 1;
        10 10 10 3;
        10 10 10 3;
        10 10 10 3;
        10 10 10 5;
       ];

% Assign Non-Clusterheads to a cluster
for c = 1:length(dist)
    [eucDist(c),clusterNum(c)] = min(dist(c,:));
end
   
k = 8; % bit length of message
Etx = zeros(CHcount,1);
Erx = zeros(CHcount,1);
for n = 1:length(dist)
    for e = 1:CHcount
        if clusterNum(n)==e
            Etx(e) = Etx(e) + Eelec*k+Eamp*k*eucDist(n)^lambda;
            Erx(e) = Erx(e) + Eelec*k;
        end
    end
end