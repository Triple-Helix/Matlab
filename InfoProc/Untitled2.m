%Read the wavefile
[x,fs]= wavread('sinusoids_2013.wav');

%Compute the spectrogram
[s,f,t]=spectrogram_hw3(x,fs,1,.0001);

%display the spectrogram
imagesc(t,f,10*log10(s+eps)); axis xy;
xlabel('Time (in seconds)')
ylabel('Frequencies (in Hz)');

%Inputs to spectrogram_hw4:
%x: signal
%fs: samplping frequency in Hz
%wintime: window time in milli seconds
%steptime: hop time in milli seconds
%Outputs from spectrogram_hw4:
%s: spectrogram
%f: frequencies in the spectrogram
%t: times at which spectrogram is calculated