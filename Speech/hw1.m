clear all
close all

ind = 2;
s = SpeechCourse;
s = set(s,'PreStimSilence',0.5);
s = set(s,'PostStimSilence',0.5);
s = set(s,'NoiseType','White');
s = set(s,'SNR',0)
s = set(s,'NoiseType','Pink');
s = set(s,'SNR',0)
s = set(s,'ReverbTime',0.3);

w = waveform(s,ind);
plot(w);