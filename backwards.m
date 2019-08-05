clear all
close all

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
  
NYo = [2 1 2 1 1 1 1 2 1 2];
length = 10;

beta = zeros(length,3);
beta(1,1) = 1;
beta(1,2) = 1;
beta(1,3) = 1;

for i = 2:length
    if NYo(1,i-1) == 1 % Happy
        beta(i,1) = (NYe(1,1)*NYt(1,1) + ... % B(S)
                     NYe(2,1)*NYt(1,2) + ...
                     NYe(3,1)*NYt(1,3)) * beta(i-1);
        beta(i,2) = (NYe(1,1)*NYt(2,1) + ... % B(C)
                     NYe(2,1)*NYt(2,2) + ...
                     NYe(3,1)*NYt(2,3)) * beta(i-1);
        beta(i,3) = (NYe(1,1)*NYt(3,1) + ... % B(R)
                     NYe(2,1)*NYt(3,2) + ...
                     NYe(3,1)*NYt(3,3)) * beta(i-1);
    else % Unhappy
        beta(i,1) = (NYe(1,2)*NYt(1,1) + ... % B(S)
                     NYe(2,2)*NYt(1,2) + ...
                     NYe(3,2)*NYt(1,3)) * beta(i-1);
        beta(i,2) = (NYe(1,2)*NYt(2,1) + ... % B(C)
                     NYe(2,2)*NYt(2,2) + ...
                     NYe(3,2)*NYt(2,3)) * beta(i-1);
        beta(i,3) = (NYe(1,2)*NYt(3,1) + ... % B(R)
                     NYe(2,2)*NYt(3,2) + ...
                     NYe(3,2)*NYt(3,3)) * beta(i-1);
    end
end
beta = flipud(beta);