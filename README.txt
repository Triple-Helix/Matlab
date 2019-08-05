Press Run the run the code. 

This code runs two signals: df1_n0L and df1_nH2
To run df1_n0L, comment out line 9 and uncomment line 8
To run df1_n2H, comment out line 8 and uncomment line 9
	when running df1_n2H, ignore spectrogram in figure 2, waveform plot in figure 4, and output wav file 1.wav

The program will output 6 figures:
figure1: spectrogram for the noisy input signal
figure2: spectrogram for the bandpass filtered output
figure3: waveform of the original noisy signal
figure4: waveform of the band-pass filtered output
figure5: waveform of the Wiener filtered output
figure6: waveform of the clean signal

The program will also write 3 wav files.
0.wav is the original noisy signal
1.wav is the band-pass filtered signal
2.wav is the Wiener filtered signal