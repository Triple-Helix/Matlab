clear all
close all

%% Define HMM Models
% NYC
NYp = [.4; ... % Sunny
       .3; ... % Cloudy
       .3];    % Rainy
%       H  U
NYe = [.9,.1; ... % Sunny
       .5,.5; ... % Cloudy
       .2,.8];    % Rainy
%     S+1 C+1 R+1 
NYt = [.7,.2,.1; ... % Sunny
       .3,.4,.3; ... % Cloudy
      .1,.2,.7];    % Rainy
NYpH = NYp'*NYe(:,1);
NYpU = NYp'*NYe(:,2);
 
% LA
LAp = [.7; ... % Sunny
       .2; ... % Cloudy
       .1];    % Rainy
%       H  U
LAe = [.9,.1; ...
       .5,.5; ...
       .2,.8];
%     S+1 C+1 R+1 
LAt = [.7,.2,.1; ... % Sunny
       .5,.3,.2; ... % Cloudy
       .3,.3,.4];    % Rainy
LApH = LAp'*LAe(:,1);
LApU = LAp'*LAe(:,2);
   
%% Generate 100 10 day observations for each city
% Let 1=Sunny; 2=Cloudy; 3=Rainy
NYs = zeros(100,10); LAs = zeros(100,10); 
NYo = zeros(100,10); LAo = zeros(100,10);
[height, length] = size(NYs);

% NY 
for i=1:100
    for j=1:10
        r = rand;
        if j==1
            NYs(i,j) = sum(r >= cumsum([0, NYp']));
        else
            if NYs(i,j-1)==1 % sunny
                NYs(i,j) = sum(r >= cumsum([0, NYt(1,:)]));
            elseif NYs(i,j-1)==2 % cloudy
                NYs(i,j) = sum(r >= cumsum([0, NYt(2,:)]));
            elseif NYs(i,j-1)==3 % rainy
                NYs(i,j) = sum(r >= cumsum([0, NYt(3,:)]));
            end
        end
    end
end
for i=1:100
    for j=1:10
        r = rand;
        if NYs(i,j)==1 % sunny
            NYo(i,j) = sum(r >= cumsum([0, NYe(1,:)]));
        elseif NYs(i,j)==2 % cloudy
            NYo(i,j) = sum(r >= cumsum([0, NYe(2,:)]));
        elseif NYs(i,j)==3 % rainy
            NYo(i,j) = sum(r >= cumsum([0, NYe(3,:)]));
        end
    end
end

% LA 
for i=1:100
    for j=1:10
        r = rand;
        if j==1
            LAs(i,j) = sum(r >= cumsum([0, LAp']));
        else
            if LAs(i,j-1)==1 % sunny
                LAs(i,j) = sum(r >= cumsum([0, LAt(1,:)]));
            elseif LAs(i,j-1)==2 % cloudy
                LAs(i,j) = sum(r >= cumsum([0, LAt(2,:)]));
            elseif LAs(i,j-1)==3 % rainy
                LAs(i,j) = sum(r >= cumsum([0, LAt(3,:)]));
            end
        end
    end
end
for i=1:100
    for j=1:10
        r = rand;
        if LAs(i,j)==1 % sunny
            LAo(i,j) = sum(r >= cumsum([0, LAe(1,:)]));
        elseif LAs(i,j)==2 % cloudy
            LAo(i,j) = sum(r >= cumsum([0, LAe(2,:)]));
        elseif LAs(i,j)==3 % rainy
            LAo(i,j) = sum(r >= cumsum([0, LAe(3,:)]));
        end
    end
end
%% NY Alpha
for h = 1:height
    NYalpha = zeros(length,3);
    NYsumAlpha = zeros(length,1);
    if LAo(h,1) == 1 % Happy
        NYalpha(1,1) = NYp(1)*NYe(1,1);
        NYalpha(1,2) = NYp(2)*NYe(2,1);
        NYalpha(1,3) = NYp(3)*NYe(3,1);
    else % Unhappy
        NYalpha(1,1) = NYp(1)*NYe(1,2);
        NYalpha(1,2) = NYp(2)*NYe(2,2);
        NYalpha(1,3) = NYp(3)*NYe(3,2);
    end
end

iter = 1;
for i = LAo(1,:)
    if iter == 1
        iter = iter+1;
    else
        if i == 1 % Happy
        NYalpha(iter,1) = (NYalpha(iter-1,1)*NYt(1,1) + ... % a(S)
                           NYalpha(iter-1,2)*NYt(2,1) + ...
                           NYalpha(iter-1,3)*NYt(3,1)) * NYe(1,1);
        NYalpha(iter,2) = (NYalpha(iter-1,1)*NYt(1,2) + ... % a(C)
                           NYalpha(iter-1,2)*NYt(2,2) + ...
                           NYalpha(iter-1,3)*NYt(3,2)) * NYe(2,1);
        NYalpha(iter,3) = (NYalpha(iter-1,1)*NYt(1,3) + ... % a(R)
                           NYalpha(iter-1,2)*NYt(2,3) + ...
                           NYalpha(iter-1,3)*NYt(3,3)) * NYe(3,1);
        else
        NYalpha(iter,1) = (NYalpha(iter-1,1)*NYt(1,1) + ... % a(S)
                           NYalpha(iter-1,2)*NYt(2,1) + ...
                           NYalpha(iter-1,3)*NYt(3,1)) * NYe(1,2);
        NYalpha(iter,2) = (NYalpha(iter-1,1)*NYt(1,2) + ... % a(C)
                           NYalpha(iter-1,2)*NYt(2,2) + ...
                           NYalpha(iter-1,3)*NYt(3,2)) * NYe(2,2);
        NYalpha(iter,3) = (NYalpha(iter-1,1)*NYt(1,3) + ... % a(R)
                           NYalpha(iter-1,2)*NYt(2,3) + ...
                           NYalpha(iter-1,3)*NYt(3,3)) * NYe(3,2);
        end
        iter = iter+1;
    end
end

for i=1:length
    NYsumAlpha(i) = NYalpha(i,1)+NYalpha(i,2)+NYalpha(i,3);
end

%% NY Beta
NYbeta = zeros(length,3,height);
NYsumBeta = zeros(length,1,height);

NYbeta(1,1) = 1;
NYbeta(1,2) = 1;
NYbeta(1,3) = 1;

for i = 2:length
    if LAo(1,i-1) == 1 % Happy
        NYbeta(i,1) = (NYe(1,1)*NYt(1,1) + ... % B(S)
                       NYe(2,1)*NYt(1,2) + ...
                       NYe(3,1)*NYt(1,3)) * NYbeta(i-1);
        NYbeta(i,2) = (NYe(1,1)*NYt(2,1) + ... % B(C)
                       NYe(2,1)*NYt(2,2) + ...
                       NYe(3,1)*NYt(2,3)) * NYbeta(i-1);
        NYbeta(i,3) = (NYe(1,1)*NYt(3,1) + ... % B(R)
                       NYe(2,1)*NYt(3,2) + ...
                       NYe(3,1)*NYt(3,3)) * NYbeta(i-1);
    else % Unhappy
        NYbeta(i,1) = (NYe(1,2)*NYt(1,1) + ... % B(S)
                       NYe(2,2)*NYt(1,2) + ...
                       NYe(3,2)*NYt(1,3)) * NYbeta(i-1);
        NYbeta(i,2) = (NYe(1,2)*NYt(2,1) + ... % B(C)
                       NYe(2,2)*NYt(2,2) + ...
                       NYe(3,2)*NYt(2,3)) * NYbeta(i-1);
        NYbeta(i,3) = (NYe(1,2)*NYt(3,1) + ... % B(R)
                       NYe(2,2)*NYt(3,2) + ...
                       NYe(3,2)*NYt(3,3)) * NYbeta(i-1);
    end
end

for i=1:length
    NYsumBeta(i) = NYbeta(i,1)+NYbeta(i,2)+NYbeta(i,3);
end

NYbeta = flipud(NYbeta);
%% E-Step

NYgamma = zeros(length,3);
NYxi = zeros(length-1,9);

% Gamma
for t = 1:length
    if LAo(t) == 1 % Happy
        NYgamma(t,1) = NYalpha(t,1)*NYbeta(t,1)/NYpH; % Y(S)
        NYgamma(t,2) = NYalpha(t,2)*NYbeta(t,2)/NYpH; % Y(C)
        NYgamma(t,3) = NYalpha(t,3)*NYbeta(t,3)/NYpH; % Y(R)
    else % Unhappy
        NYgamma(t,1) = NYalpha(t,1)*NYbeta(t,1)/NYpU; % Y(S)
        NYgamma(t,2) = NYalpha(t,2)*NYbeta(t,2)/NYpU; % Y(C)
        NYgamma(t,3) = NYalpha(t,3)*NYbeta(t,3)/NYpU; % Y(R)
    end
end
% Xi
for t = 1:length-1
    if LAo(h,t+1)==1 % Happy
        NYxi(t,1) = NYalpha(t,1)*NYt(1,1)*NYe(1,1)*NYbeta(t+1,1)/ ... % E(S,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,2) = NYalpha(t,1)*NYt(1,2)*NYe(2,1)*NYbeta(t+1,1)/ ... % E(S,C)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,3) = NYalpha(t,1)*NYt(1,3)*NYe(3,1)*NYbeta(t+1,1)/ ... % E(S,R)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,4) = NYalpha(t,1)*NYt(2,1)*NYe(1,1)*NYbeta(t+1,1)/ ... % E(C,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,5) = NYalpha(t,1)*NYt(2,2)*NYe(2,1)*NYbeta(t+1,1)/ ... % E(C,C)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,6) = NYalpha(t,1)*NYt(2,3)*NYe(3,1)*NYbeta(t+1,1)/ ... % E(C,R)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,7) = NYalpha(t,1)*NYt(3,1)*NYe(1,1)*NYbeta(t+1,1)/ ... % E(R,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,8) = NYalpha(t,1)*NYt(3,2)*NYe(2,1)*NYbeta(t+1,1)/ ... % E(R,S)
                      (NYsumAlpha(t)*NYsumBeta(t,h));
        NYxi(t,9) = NYalpha(t,1)*NYt(3,3)*NYe(3,1)*NYbeta(t+1,1)/ ... % E(R,S)
                      (NYsumAlpha(t)*NYsumBeta(t,h));
    else % Unhappy
        NYxi(t,1) = NYalpha(t,1)*NYt(1,1)*NYe(1,2)*NYbeta(t+1,1)/ ... % E(S,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,2) = NYalpha(t,1)*NYt(1,2)*NYe(2,2)*NYbeta(t+1,1)/ ... % E(S,C)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,3) = NYalpha(t,1)*NYt(1,3)*NYe(3,2)*NYbeta(t+1,1)/ ... % E(S,R)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,4) = NYalpha(t,1)*NYt(2,1)*NYe(1,2)*NYbeta(t+1,1)/ ... % E(C,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,5) = NYalpha(t,1)*NYt(2,2)*NYe(2,2)*NYbeta(t+1,1)/ ... % E(C,C)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,6) = NYalpha(t,1)*NYt(2,3)*NYe(3,2)*NYbeta(t+1,1)/ ... % E(C,R)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,7) = NYalpha(t,1)*NYt(3,1)*NYe(1,2)*NYbeta(t+1,1)/ ... % E(R,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,8) = NYalpha(t,1)*NYt(3,2)*NYe(2,2)*NYbeta(t+1,1)/ ... % E(R,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
        NYxi(t,9) = NYalpha(t,1)*NYt(3,3)*NYe(3,2)*NYbeta(t+1,1)/ ... % E(R,S)
                      (NYsumAlpha(t)*NYsumBeta(t));
    end
end

NYhappySumGamma = zeros(1,3);
    
for i=1:length
    if LAo(i)==1 % Happy
        NYhappySumGamma(1) = NYhappySumGamma(1) + NYgamma(i,1);
        NYhappySumGamma(2) = NYhappySumGamma(2) + NYgamma(i,2);
        NYhappySumGamma(3) = NYhappySumGamma(3) + NYgamma(i,3);
    else
        NYunhappySumGamma(1) = NYhappySumGamma(1) + NYgamma(i,1);
        NYunhappySumGamma(2) = NYhappySumGamma(2) + NYgamma(i,2);
        NYunhappySumGamma(3) = NYhappySumGamma(3) + NYgamma(i,3);
    end
end
NYsumGamma = sum(NYgamma);
NYsumXi = sum(NYxi);

aij = zeros(3,3);
aij(1,1) = NYsumXi(1,1)/NYsumGamma(1);
aij(1,2) = NYsumXi(1,2)/NYsumGamma(2);
aij(1,3) = NYsumXi(1,3)/NYsumGamma(3);
aij(2,1) = NYsumXi(1,4)/NYsumGamma(1);
aij(2,2) = NYsumXi(1,5)/NYsumGamma(2);
aij(2,3) = NYsumXi(1,6)/NYsumGamma(3);
aij(3,1) = NYsumXi(1,7)/NYsumGamma(1);
aij(3,2) = NYsumXi(1,8)/NYsumGamma(2);
aij(3,3) = NYsumXi(1,9)/NYsumGamma(3);

sumaij = sum(aij');
NYt = [aij(1,1)/sumaij(1), aij(1,2)/sumaij(2), aij(1,3)/sumaij(3);
       aij(2,1)/sumaij(1), aij(2,2)/sumaij(2), aij(2,3)/sumaij(3);
       aij(3,1)/sumaij(1), aij(3,2)/sumaij(2), aij(3,3)/sumaij(3)];

bi = zeros(3,2);
bi(1,1) = NYhappySumGamma(1)/NYsumGamma(1);
bi(2,1) = NYhappySumGamma(2)/NYsumGamma(2);
bi(3,1) = NYhappySumGamma(3)/NYsumGamma(3);
bi(1,2) = NYunhappySumGamma(1)/NYsumGamma(1);
bi(2,2) = NYunhappySumGamma(2)/NYsumGamma(2);
bi(3,2) = NYunhappySumGamma(3)/NYsumGamma(3);

sumbi = sum(bi');
NYe = [bi(1,1)/sumbi(1), bi(1,2)/sumbi(1);
       bi(2,1)/sumbi(2), bi(2,2)/sumbi(2);
       bi(3,1)/sumbi(3), bi(3,2)/sumbi(3)];