clear all
close all

s = SpeechCourse;
f = get(s,'SamplingRate');
%% work with SpeechEvents method to estimate the phonemes:
% what are the instances of phoneme 's' in the corpus?
evS = SpeechEvents(s,'phonemes','s');
% ev is a structure, size(s) = number of 's' phonemes in the corpus
% ev.Trial is the index of the speech
% ev.StartTime is the onset of phoneme
% ev.StopTime is the offset of phoneme
%% deleting the 's' phoneme 
w1 = waveform(s,1); % first sentence
w2 = w1; 
TrialS = cat(1,evS.Trial);

ind = find(TrialS==1);
for cnt1 = ind'
    w2(evS(cnt1).StartTime*f:evS(cnt1).StopTime*f) = 0;
end
figure(1)
plot(w1);
hold on
plot(w2,'r');
soundsc(w1,f); % with s
soundsc(w2,f); % without the 's' phoneme
%% working with auditory spectrogram
% download the nsltools from coursework and add to path
figure;loadload;close; % initialization code
aud1 = wav2aud (w1,[10 10 -2 0]).^.3;
aud2 = wav2aud (w2,[10 10 -2 0]).^.3;
figure(2)
subplot(2,1,1);
imagesc(aud1');axis xy
subplot(2,1,2);
imagesc(aud2');axis xy
%% P1: Compute auditory spectrogram of 1st sentence and compare to fft spectrogram.
figure(3)
spectrogram(w1,128,120,128,f,'yaxis');
title('P1: FFT Spectogram')
% Comments: We can see similarities between the two different spectrograms.
% From [.5,1] seconds, we can see a similar downward concave shape. 
% However, from [1,1.3] seconds, we see a large band in the fft spectrogram
% and another one from [.35,.5] seconds.
%% P2: Calculate the histogram of the duration of phonemes 'aa', 's', 't', and 'n'.
evAA = SpeechEvents(s,'phonemes','aa');
evT  = SpeechEvents(s,'phonemes','t');
evN  = SpeechEvents(s,'phonemes','n');

figure(4)

StartTimeAA = zeros(1,length(evAA));
StopTimeAA  = zeros(1,length(evAA));
durationAA  = zeros(1,length(evAA));
for cntAA = 1:length(evAA)
    StartTimeAA(cntAA) = evAA(cntAA).StartTime;
    StopTimeAA(cntAA)  = evAA(cntAA).StopTime;
    durationAA(cntAA) = StopTimeAA(cntAA) - StartTimeAA(cntAA);
end
subplot(2,2,1);
hist(durationAA);
title('Histogram aa');

StartTimeS = zeros(1,length(evS));
StopTimeS  = zeros(1,length(evS));
durationS  = zeros(1,length(evS));
for cntS = 1:length(evS)
    StartTimeS(cntS) = evS(cntS).StartTime;
    StopTimeS(cntS)  = evS(cntS).StopTime;
    durationS(cntS) = StopTimeS(cntS) - StartTimeS(cntS);
end
subplot(2,2,2);
hist(durationS);
title('Histogram s');

StartTimeT = zeros(1,length(evT));
StopTimeT  = zeros(1,length(evT));
durationT  = zeros(1,length(evT));
for cntT = 1:length(evT)
    StartTimeT(cntT) = evT(cntT).StartTime;
    StopTimeT(cntT)  = evT(cntT).StopTime;
    durationT(cntT) = StopTimeT(cntT) - StartTimeT(cntT);
end
subplot(2,2,3);
hist(durationT);
title('Histogram t');

StartTimeN = zeros(1,length(evN));
StopTimeN  = zeros(1,length(evN));
durationN  = zeros(1,length(evN));
for cntN = 1:length(evN)
    StartTimeN(cntN) = evN(cntN).StartTime;
    StopTimeN(cntN)  = evN(cntN).StopTime;
    durationN(cntN) = StopTimeN(cntN) - StartTimeN(cntN);
end
subplot(2,2,4);
hist(durationN);
title('Histogram n');
%% P3: Determine average auditory and Fourier Spectrograms for phonemes 'aa', 's', 't', and 'n'.
TrialAA = cat(1,evAA.Trial);
TrialT  = cat(1,evT.Trial);
TrialN  = cat(1,evN.Trial);
figure(5)

wavAA = zeros(.2*f+1,1);
for nAA = 1:cntAA
    wavSentence = waveform(s,TrialAA(nAA));
    StartIndex = evAA(nAA).StartTime*f;
    StopIndex = StartIndex+3200;
    wavAA = wavAA + wavSentence(StartIndex:StopIndex);
end
wavAA = wavAA/cntAA;
audAA = wav2aud (wavAA,[10 10 -2 0]).^.3;
subplot(2,2,1)
imagesc(audAA')
title('Average Auditory Spectrogram of aa')

wavS = zeros(.2*f+1,1);
for nS = 1:cntS
    wavSentence = waveform(s,TrialS(nS));
    StartIndex = evS(nS).StartTime*f;
    StopIndex = StartIndex+3200;
    wavS = wavS + wavSentence(StartIndex:StopIndex);
end
wavS = wavS/cntS;
audS = wav2aud (wavS,[10 10 -2 0]).^.3;
subplot(2,2,2)
imagesc(audS')
title('Average Auditory Spectrogram of s')

wavT = zeros(.2*f+1,1);
for nT = 1:cntT
    wavSentence = waveform(s,TrialT(nT));
    StartIndex = evT(nT).StartTime*f;
    StopIndex = StartIndex+3200;
    wavT = wavT + wavSentence(StartIndex:StopIndex);
end
wavT = wavT/cntT;
audT = wav2aud (wavT,[10 10 -2 0]).^.3;
subplot(2,2,3)
imagesc(audT')
title('Average Auditory Spectrogram of t')

wavN = zeros(.2*f+1,1);
for nN = 1:cntN
    wavSentence = waveform(s,TrialN(nN));
    wavSentence(end+10000) = 0;
    StartIndex = evN(nN).StartTime*f;
    StopIndex = StartIndex+3200;
    wavN = wavN + wavSentence(StartIndex:StopIndex);
end
wavN = wavN/cntN;
audN = wav2aud (wavN,[10 10 -2 0]).^.3;
subplot(2,2,4)
imagesc(audN')
title('Average Auditory Spectrogram of n')

figure (6) 
subplot(2,2,1)
spectrogram(wavAA,128,120,128,f,'yaxis');
title('FFT Spectrogram of aa');

subplot(2,2,2)
spectrogram(wavS,128,120,128,f,'yaxis');
title('FFT Spectrogram of s');

subplot(2,2,3)
spectrogram(wavT,128,120,128,f,'yaxis');
title('FFT Spectrogram of t');

subplot(2,2,4)
spectrogram(wavN,128,120,128,f,'yaxis');
title('FFT Spectrogram of n');