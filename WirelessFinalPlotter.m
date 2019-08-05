clear all
close all

% Parametrs
% Field Dimensions
    xm = 100;
    ym = 100;
% Threshold Parameters
    % Clusterhead Probablity
    p = .05;
    
% Populate field with nodes
    xCoor = rand(xm,1)*10;
    yCoor = rand(ym,1)*10;

rmax = 1;
AllNodes = [xCoor yCoor];
G = [xCoor yCoor]; 

for r = 1:rmax
    CH = [0 0];
    NCH = [xCoor yCoor]; % reset Not Clusterhead list
    
    % Determine Clusterheads
    % Assign random numbers to each index in G
    CHcount = 0;
    CHindex = 0;
    [hei, ~] = size(G);
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
            dist(j,i) = norm(CH(i,:)-NCH(j,:));
        end
    end
    
    % Assign Non-Clusterheads to a cluster
    for c = 1:length(dist)
        [eucDist(c),clusterNum(c)] = min(dist(c,:));
    end
end

figure(1)
for d = 1:length(dist)
    if clusterNum(d)==1
        scatter(NCH(d,1),NCH(d,2),'g','fill')
    elseif clusterNum(d)==2
        scatter(NCH(d,1),NCH(d,2),'y','fill')
    elseif clusterNum(d)==3
        scatter(NCH(d,1),NCH(d,2),'b','fill')
    elseif clusterNum(d)==4
        scatter(NCH(d,1),NCH(d,2),'r','fill')
    elseif clusterNum(d)==5
        scatter(NCH(d,1),NCH(d,2),'m','fill')
    elseif clusterNum(d)==6
        scatter(NCH(d,1),NCH(d,2),'c','fill')
    elseif clusterNum(d)==7
        scatter(NCH(d,1),NCH(d,2),'k','fill')
    end
    hold on
end

for q = 1:CHcount
    scatter(CH(q,1),CH(q,2),'x')
end