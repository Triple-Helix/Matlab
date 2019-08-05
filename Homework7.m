clear all
close all

%% comparison of FFT, Mel, and PLP spectra for male and female speakers
male_index = [1 2 3];
female_index = [4 5 7];

s = SpeechCourse;
s = set(s,'subsets',1);
f = get(s,'SamplingRate');
mw1 = waveform(s,male_index(1)); % first sentence
mw2 = waveform(s,male_index(2));
mw3 = waveform(s,male_index(3));
mwtot = cat(1,cat(1,mw1,mw2),mw3);

fw1 = waveform(s,female_index(1));
fw2 = waveform(s,female_index(2));
fw3 = waveform(s,female_index(3));
fwtot = cat(1,cat(1,fw1,fw2),fw3);
%% mel frequency spectrogram
figure(1)
[cepstra,aspectrum,pspectrum] = melfcc(mw1,f,'nbands',20);
subplot(3,1,1);
imagesc(log(pspectrum));axis xy
title('FFT spectrogram');
subplot(3,1,2);
imagesc(log(aspectrum));axis xy;
title('mel spectrogram');
subplot(3,1,3);
imagesc(cepstra);axis xy;
title('MFCC')
%% Perceptual Linear Prediction 
figure(2)
[cepstra,aspectrum,pspectrum] = rastaplp(mw1,f,0,12);
subplot(3,1,1);
imagesc(log(pspectrum));axis xy
title('FFT spectrogram');
subplot(3,1,2);
imagesc(log(aspectrum));axis xy;
title('mel spectrogram');
subplot(3,1,3);
imagesc(cepstra);axis xy;
title('PLP')
%% Average Time Dimension of FFT, Mel, and POL spectra for male and female sounds
[mcepstra,maspectrum,mpspectrum] = melfcc(mwtot,f,'nbands',20);
[fcepstra,faspectrum,fpspectrum] = melfcc(fwtot,f,'nbands',20);

figure(3)
plot(mean(log(maspectrum),2),'b');
hold on
plot(mean(log(faspectrum),2),'r');
title('mel spectrogram time average spectrum plot')

[mcepstra,maspectrum,mpspectrum] = rastaplp(mwtot,f,0,12);
[fcepstra,faspectrum,fpspectrum] = rastaplp(fwtot,f,0,12);

figure(4)
plot(mean(mcepstra,2),'b');
hold on
plot(mean(fcepstra,2),'r');
title('PLP time average spectrum plot')

figure(5)
plot(mean(log(mpspectrum),2),'b');
hold on
plot(mean(log(fpspectrum),2),'r');
title('FFT time average spectrum plot')
