clear all
close all
%Constants:
 
%!A Plot
 
% RT/F = 25 mV (given)
delta = (3/4).*cos(pi/4);
z=-4; % valence (given)
V=(-100:100); %mV
G_D = 3;
G_E = 4;
 
k_DE = 100.*exp(-G_D).*exp(-delta.*z.*V./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*V./25);    
 
semilogy(V,k_DE,'b',V,k_ED,'r')
legend('k_D_E','k_E_D','Location','NorthWest')
title('1A Gate Rate Constants vs. Transmembrane Voltage')
xlabel('Vm (mV)')
ylabel('Transition Rate (ms^-1)')
 
%1B Plot
 
p_Ess = k_DE./(k_DE+k_ED);
p_Dss = k_ED./(k_DE+k_ED);
 
figure
plot(V,p_Ess,'b',V,p_Dss,'r')
legend('p_E','p_D','Location','NorthWest')
title('2A Gate State Probabilities vs. Transmembrane Voltage')
xlabel('Vm (mV)')
ylabel('State Probability')
 
%1C
 
tau = 1./(k_DE+k_ED);
 
figure
semilogy(V,log(tau),'g')
title('3A Enabled State Probability Time Constant vs. Transmembrane Voltage')
xlabel('Vm (mV)')
ylabel('Time Constant (ms)')
 
%1D
figure
%{
V = -100;
N_channels = 1000;
g_single = .01;
V_reversal = 50;
t_1 = (-.5:.01:0);
t_2 = (0:.01:3);
t_3 = (3:.01:3.5);
%{
k_DE = 100.*exp(-G_D).*exp(-delta.*z.*V./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*V./25);
 
p_Ess = k_DE./(k_DE+k_ED);
p_Dss = k_ED./(k_DE+k_ED);
 
I_1 = (p_Dss.*exp(-(k_DE+k_ED).*t_1)+p_Ess).*N_channels.*g_single.*(V-V_reversal);
plot(t_1,I_1)
 
hold on
%}
V = 0;
 
k_DE = 100.*exp(-G_D).*exp(-delta.*z.*V./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*V./25);
 
p_Ess = k_DE./(k_DE+k_ED);
p_Dss = k_ED./(k_DE+k_ED);
 
I_2 = (p_Dss.*exp(-(k_DE+k_ED).*t_2)+p_Ess).*N_channels.*g_single.*(V-V_reversal);
plot(t_2,I_2)
%}
G_D = 3;
G_E = 4;
delta = (3/4).*cos(pi/4);
z=-4;

t_1 = (-.5:.01:0);
t_2 = (0:.01:3);
t_3 = (3:.01:3.5);
Vm_1 = -100;
Vm_2 = 0;
Vm_3 = -100;
N_channels = 1000;
g_single = .01;
V_reversal = 50;
 
k_DE1 = 100.*exp(-G_D).*exp(-delta.*z.*Vm_1./25);
k_ED1 = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*Vm_1./25); 
k_DE2 = 100.*exp(-G_D).*exp(-delta.*z.*Vm_2./25);
k_ED2 = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*Vm_2./25); 
k_DE3 = 100.*exp(-G_D).*exp(-delta.*z.*Vm_3./25);
k_ED3 = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*Vm_3./25); 
 
 
p_Ess1 = k_DE1./(k_DE1+k_ED1);
p_Dss1 = k_ED1./(k_DE1+k_ED1);
p_Ess2 = k_DE2./(k_DE2+k_ED2);
p_Dss2 = k_ED2./(k_DE2+k_ED2);
p_Ess3 = k_DE3./(k_DE3+k_ED3);
p_Dss3 = k_ED3./(k_DE3+k_ED3);
 
I_1 = p_Ess1.*N_channels.*g_single.*(Vm_1-V_reversal);
I_2 = (p_Ess1+(p_Ess2-p_Ess1).*(1-exp(-(k_DE2+k_ED2).*t_2))).*N_channels.*g_single.*(Vm_2-V_reversal);
I_3 = (p_Dss3.*exp(-(k_DE3+k_ED3).*t_3)+p_Ess3).*N_channels.*g_single.*(Vm_3-V_reversal);
 
plot(t_1,I_1,t_2,I_2,t_3,I_3)
 



k_DE = 100.*exp(-G_D).*exp(-delta.*z.*-100./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*-100./25);
whee=-k_DE./(k_DE+k_ED).*exp(-(k_DE+k_ED).*t_1)+k_DE./(k_DE+k_ED).*N_channels.*g_single.*(-100-50)
plot(t_1,whee)

%whee=N_channels.*g_single.*(-100-50)
figure
k_DE = 100.*exp(-G_D).*exp(-delta.*z.*0./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*0./25); 
whaa=-k_DE./(k_DE+k_ED).*exp(-(k_DE+k_ED).*t_2)+k_DE./(k_DE+k_ED).* N_channels.*g_single.*(-50)
%plot(t_1,whee,t_2,whaa)
plot(t_2,whaa)

k_DE = 100.*exp(-G_D).*exp(-delta.*z.*-100./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*-100./25); 
whoo=-k_DE./(k_DE+k_ED).*exp(-(k_DE+k_ED).*t_3)+k_DE./(k_DE+k_ED).* N_channels.*g_single.*(-100-50)
%plot(t_1,whee,t_2,whaa,t_3,whoo)
plot(t_3,whoo)

%{
t = (-.5:.01:3.5);
N_channels = 1000;
g_single = .01;
V_reversal = 50;
 
 
k_DE = 100.*exp(-G_D).*exp(-delta.*z.*Vm_earth(t)./25);
k_ED = 100.*exp(-G_E).*exp(((3/4)-delta).*z.*Vm_earth(t)./25); 
 
p_Ess = k_DE./(k_DE+k_ED);
p_Dss = k_ED./(k_DE+k_ED);
 
p_E = (p_Dss.*exp(-1.*(k_DE+k_ED).*t))+p_Ess;
 
I = p_E.*N_channels.*g_single.*(Vm_earth(t)-V_reversal);
 
plot(t,I)
%}