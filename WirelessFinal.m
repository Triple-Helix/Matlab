clear all
close all

% Parametrs
% Field Dimensions
    xm = 100;
    ym = 100;
% Energy constants
    % Energy dissipated rinning Tx & Rx circuits
    Eelec = 50e-9; %nJ/bit
    % Energy dissipated from transmission amplifier
    Eamp = 100e-12; %pJ/bit/m^2
    % Path Loss
    lambda = 2;
    % Node Battery Life
    Emax = 1e-4;
% Threshold Parameters
    % Clusterhead Probablity
    p = .05;
    
% Populate field with nodes
    xCoor = rand(xm,1)*10;
    yCoor = rand(ym,1)*10;
% Assign initial battery life to each node
    currBatt = zeros(xm,1) + Emax;
    
rmax = 1/p-1; % Number of rounds
NCH = [xCoor yCoor currBatt];
G = [xCoor yCoor currBatt];
CH = [];

for r = 1:rmax
    % Determine Clusterheads
    % Assign random numbers to each index in G
    CHcount = 0;
    CHindex = 0;
    [hei, len] = size(G);
    Grand = rand(1,hei);
    % Threshold Function
    % Sochastic T(r)
    T(r) = p/(1-p*(mod(r,1/p)));
    % Energy Aware T(r)
%     for t = length(NCH)
%         T(r) = p/(1-p*(mod(r,1/p)))*(NCH(t,3))/Emax;
%     end
    for n = 1:hei
        if Grand(n) < T(r)
            CHcount = CHcount+1;
            CH(CHcount,:) = G(n,:);
            CHindex(CHcount) = n;
        end
    end
    
    % Update G by popping out Clusterheads
    gcnt = 0;
    if CHindex ~= 0
        for g = CHindex
            G(g-gcnt,:) = [];
            gcnt = gcnt+1;
        end
        % Update NCH
        ccnt = 0;
        for c = CHindex
            NCH(c-ccnt,:) = [];
            ccnt = ccnt+1;
        end
    end
    % Generate dist matrix of distances of each node from the Clusterheads
    dist = zeros(length(NCH),CHcount);
    for i = 1:CHcount % iterates through columns of dist
        for j = 1:length(NCH) % iterates through rows of NCH
            dist(j,i) = norm(CH(i,[1 2])-NCH(j,[1 2]));
        end
    end
    
    % Calculate energy used to transmit/receive
    k = 8; % bit length of message
    for c = 1:length(dist)
        [eucDist(c),clusterNum(c)] = min(dist(c,:));
    end
    [clusterCount,clusterIndex] = hist(clusterNum,unique(clusterNum));
    for n = 1:length(dist)
        Etx = Eelec*k+Eamp*k*eucDist(n)^lambda;
        NCH(n,3) = NCH(n,3)-Etx;
    end
    for m = 1:CHcount-1
        Erx = Eelec*k;
        CH(m,3) = CH(m,3) - Erx*clusterCount(m);
    end
    NCH = [NCH;CH]; % update all nodes list into NCH
    CH = []; % clear cluster head list
    NCH(NCH(:,3)<.00009,:) = [];
    if length(NCH) < xm
        disp('FND')
        disp(r)
    end
    if length(NCH) < xm/2
        disp('HND')
        disp(r)
    end
end