% Calculating average fade duration and plotting envelope of Rayleigh distribution for specified value of fm and ro %
%************************** ****************************************************************************************%
close all
clear all
clc

N=256;    %Number of frequency samples
M=8192;   %Number of time samples 

% Required parameters for INPUT: fm and row (r0)

fm=input('ENTER THE VALUE OF fm [20 Hz, 200Hz]:')
r0=input('ENTER THE VALUE OF r0 [1,0.1,0.01]:')

y=1;
Afd_p=0;                   % Average fade duration; practical value
Nr_p=0;                    % Number of Zero-crossing level per second
Rrms_p=0;                  % Practically calculated R-rms value

while(y<=1)
    
    delta_f=2*fm/N;        % Frequency resolution
    delta_t=N/(M-1)/2/fm;  % Time resolution

%*************************   NOTE   **********************************%
% "If N=M-1, then the time resolution delta_t=1/2*fm, which may not be
% small so take M >> N. When M > N, we need to pad with zero values
% before taking IFFT."


X1(1)=randn(1);            % Generating Gaussain Random with N(0,1)
X1=X1(1);
Y1(1)=randn(1);
Y1=Y1(1);  

for m=2:(N/2)+1
    X1(m)=randn(1);
    X2(m)=randn(1);
    Y1(m)=randn(1);
    Y2(m)=randn(1);
    X(m)=X1(m)+i*X2(m);
    Y(m)=Y1(m)+i*Y2(m);
end

for m=1:(N/2)+1
    X(M-m+1)=conj(X(m+1));
    Y(M-m+1)=conj(Y(m+1));
end

% Sample Se(f) Spectrum

for jj=1:N/2               
SeF(jj)=1.5/(pi*fm*(sqrt(1-((jj-1)*delta_f/fm)^2))); 
end

% Calculating Edge Value by extending the slope prior to passband edge to edge

SeF((N/2)+1)=SeF(N/2)+SeF(N/2)-SeF((N/2)-1); 

for m=1:N/2
SeF(M-m+1)=SeF(m+1);
end

for m=1:M
    X_shaped(m)=X(m)*sqrt(SeF(m));
    Y_shaped(m)=Y(m)*sqrt(SeF(m));
end

X_component=real(ifft(X_shaped));   % Only considering the real part
Y_component=real(ifft(Y_shaped));

%************* Find R-rms value and envelope of Rayleigh Distribution ***********%

R=sqrt(X_component.^2+Y_component.^2);
r=20*log10(R);

rms=sqrt(mean(R.^2));
Rrms=20*log10(rms);
level=20*log10(r0*rms);
R=r-Rrms;

figure
plot(1:8192,R,'r')
xlabel ('Time Samples, M=8192');
ylabel ('Instantaneous Power dB');
title ('Figure(1):Rayleigh fading signal for Specified fm & r0 ');

%  Calculating (Practically) Number of Zero Level Crossing and Average Fade Duration  %

h=1;
c=0;
C1=0;
NUM=0;
  while h<=M
  if r(h)<=level
      i=h;
      while i<=M
          if r(i)>=level
              NUM=NUM+1;
              break;
          end
          i=i+1;
      end
      c=i-h;
      C1=C1+c;
      h=i-1;
  end
  h=h+1;
end    

Afd_p=Afd_p+(C1/NUM)*delta_t;
Nr_p=Nr_p+NUM*delta_f;
Rrms_p=Rrms_p+Rrms;
y=y+1;
end

%************ Theoretical calculation of  Number of Zero Level Crossing (Nr) and Average Fade Duration ************* %

Nr_theoretical=sqrt(2*pi)*fm*r0*exp(-r0^2); 

z1=exp(r0^2)-1;
z2=r0*fm*sqrt(2*pi);  
Average_fade_duration_theoretical =z1/z2;

rowdb=10*log10(r0) ;
Rrms_theoretical=Rrms+rowdb;

%*********************** Displayiing Calculated values  ************************ %

Nr_practical=(Nr_p);
Nr_practical
Nr_theoretical
Average_fade_duration_Practical=(Afd_p);
Average_fade_duration_Practical
Average_fade_duration_theoretical =z1/z2
Rrms_Practical=Rrms_p
Rrms_theoretical