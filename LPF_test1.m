Fc = 20e3; % 8.25 kHz cutoff frequency
Fs = 96e3; % 96 kHz sampling frequency
N  = 100;  % FIR filter order

[noisyfemale, Fs] = wavread('noisyfemale.wav');

plot(noisyfemale);
LP = fdesign.lowpass('N,Fc',N,Fc,Fs);