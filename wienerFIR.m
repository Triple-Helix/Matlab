clc
clear all
close all
delete 0.wav
delete 1.wav
delete 2.wav

% [dd,r] = wavread('df1_n0L.wav'); %uncomment this part for the low noise
[dd,r] = wavread('df1_n2H.wav'); %uncomment this part for the high nosie
[s,r] = wavread('df1_cln.wav');  % clean signal
figure (1)
specgram(dd,1024,r); %obtain filter freq's from looking at specgram
title('Input Specgram')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
wavwrite(dd,r,'0.wav'); % original signal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make a bandpass filter
[b a] = ellip(6,0.5,50,2300/(r/2),'low');   % get rid of f>2300Hz
df = filter(b,a,dd);
sdf = filter(b,a,s);
[b a] = ellip(8,0.5,50,400/(r/2),'high');   % get rid of f<400
d = filter(b,a,df);
sd = filter(b,a,sdf);

t = 0;
c6 = dd'*dd;                  % inner product for energy
c7 = s'*s;
s = s*sqrt(c6/c7);            % normalize the total energy
nn = size(d);
N = nn(1);
wavwrite(d,r,'1.wav');        % Bandpass filter to eleiminate some noise. Not perfect, but we can do better

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIR Filter
n = 64; %FIR Filter length 64. tested around with 2^n. 64 seemed good with time with good enough result
n2 = 6*n; %much longer b/c when do auto correlation, theres and edging effect. longer to reduce edge effect

Y = zeros(1,N);
fid = fopen('1.txt','w');
fid2 = fopen('2.txt','w');
aa = zeros(1,3);

d1=dd(1:500);
AR=autocorr(d1,n2-1);
c8 = d1'*d1;
c8 = 0.7*c8*n2/500;
Nc=AR(1:n);

for k=1:n2-t
y2=dd(k+n2-1:-1:k);          % last item of is the most recent
s2=s(k+n2-1:-1:k);          % last item of is the most recent
AR = autocorr(y2,n-1);        % produce n+1 elements with AR(1)=1
Ry2=AR(1:n);    
R = toeplitz(Ry2);
AR = crosscorr(s2,y2,n-1);
Rxy=AR(1:n);
h=R\Rxy;
y=dd(k:k+n-1);
aa(2) = h.'*y;  
aa(3)=dd(k);
fprintf(fid,'%f\t%f\t%f\t%f\n',k/8000., aa(1),aa(2),aa(3));
Y(k) = (0.0*aa(1)+0.5*aa(2)+0*aa(3));
end

for k=n2-t:N-n2-2
% going left to right
y1=dd(k-n2+1:k);			    	% autocorr require last item the recent
s1=s(k-n2+1+t:k+t);				% autocorr require last item the recent
AR = autocorr(y1,n-1);          % autocorr of y1 with n+1 delay, produce n+1 elements with AR(1)=1
Ry1=AR(1:n);                    % just take the first 64 samples of AR. dont need the rest
R = toeplitz(Ry1);              % form matrix based on the autocorrelation (Ry from the paper)
AR = crosscorr(s1,y1,n-1);      % cross correlation of clean signal and noisy signal
Rxy1=AR(1:n);                   % load cross correlation into Rxy
h=R\Rxy1;                       % solve for h vector
y=dd(k:-1:k-n+1);                % fold d (input y) for convolution
aa(1) = h.'*y;                  % solve for inner product (sk hat) based on left side computation. estimation of d(k)

% use other side of the wave form the estimate the opposite side (going right to left)
y2=dd(k+n2-1:-1:k);              % last item of is the most recent
s2=s(k+n2-1+t:-1:k+t);          % last item of is the most recent
AR = autocorr(y2,n-1);          % produce n+1 elements with AR(1)=1
Ry2=AR(1:n);
R = toeplitz(Ry2);
AR = crosscorr(s2,y2,n);
Rxy2=AR(1:n);
h=R\Rxy2;
y=dd(k:k+n-1);
aa(2) = h.'*y;                  % aa based on right side computation. estimation of d(k)
aa(3) = dd(k);                   % noisy speech from original file
aa(4) = Rxy1.'*Ry1;
aa(5) = Rxy2.'*Ry2;
if k == 5171
    i=i;
end
fprintf(fid,'%f\t%f\t%f\t%f\t%f\t%f\n',k/8000., aa(1),aa(2),aa(3),aa(4),aa(5));
Y(k) = (0.5*aa(1)+0.0*aa(2)+0*aa(3));
end

Y=Y.';
c6 = dd'*dd;   % energy for the noisy signal dd
c7 = Y.'*Y;    % energy for the new y.
Y = Y*sqrt(c6/c7);  % normalize y to maintain volume of the original
figure(2)
specgram(Y,1024,r);
title('Output Specgram')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
wavwrite(Y,r,'2.wav');


c3 = Y(n2:16998);
cc(4) = c3'*c3;  %wiener filtered
c3 = d(n2:16998);
cc(3) = c3'*c3;  %bp filtered
c3 = dd(n2:16998);
cc(2) = c3'*c3;  %original
c3 = s(n2:16998);
cc(1) = c3'*c3;  %clean signal

cc    %energy in noise only time interval to see the effects

%Normalize energy for error calculation
Y = Y*cc(1)/cc(4); %Normalize wiener
d = d*cc(1)/cc(3); %Normalize bp

%        bp w
alpha = [15 9];  %delay of the filters
Y = delay(Y,alpha(2));
d = delay(d,alpha(1));
% sY = delay(sY,alpha(2));
% sd = delay(sd,alpha(1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%error calculations
errorW = 0;
errorBP = 0;

for i = 1:16998
    errorW = errorW + (s(i)-Y(i))^2;
    errorBP = errorBP + (s(i)-d(i))^2;
end
errorW
errorBP

for j=1:N
    fprintf(fid2,'%f\t%f\t%f\t%f\n',j/8000., dd(j),d(j),Y(j));
end

figure(3)
plot(dd)
title('Original Waveform')
xlabel('Samples')
ylabel('Amplitude')
axis([0,16000,-.6,.6])

figure(4)
plot(d)
title('Band-Pass Filtered Waveform')
xlabel('Samples')
ylabel('Amplitude')
axis([0,16000,-.6,.6])

figure(5)
plot(Y)
title('Wiener Filtered Waveform')
xlabel('Samples')
ylabel('Amplitude')
axis([0,16000,-.6,.6])

figure(6)
plot(s)
title('Clean Waveform')
xlabel('Samples')
ylabel('Amplitude')
axis([0,16000,-.6,.6])