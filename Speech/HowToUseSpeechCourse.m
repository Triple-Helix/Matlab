%% This is a tutorial for how to use SpeechCourse
% DO NOT use 'Run', evaluate line by line to see how the object changes
% written by Minda Yang for the Speech and Audio Processing Course Spring 2015
% contact:my2407@columbia.edu 
%% Create a object and set subsets
s = SpeechCourse;
s = set(s,'subsets', 1); % there are five subsets in total

%% get waveform
ind = 2; % index of the audio files you want to extract
w = waveform(s,ind);
soundsc(w,16000);

%% set silence before and after sounds
s = set(s,'PreStimSilence',0.5);
s = set(s,'PostStimSilence',0.5);

%% set noise
s = set(s,'NoiseType','White'); % set the noise type as pink noise
s = set(s,'SNR',0); % set the signal to noise ratio to 10dB
ind = 2; % index of the audio files you want to extract
w = waveform(s,ind);
soundsc(w,16000);

%% set reverbration
s = set(s,'ReverbTime',0.3);
ind = 2; % index of the audio files you want to extract
w = waveform(s,ind);
soundsc(w,16000);

% remove the noise and listen again
s = set(s,'SNR',1000); % set the SNR to 1000dB to 'remove' the noise
ind = 2; % index of the audio files you want to extract
w = waveform(s,ind);
soundsc(w,16000);

%% get fields
% get audio file names
Name = get(s,'Names');

% get Phnoneme 
Phn = get(s,'Phonemes');

% get Words
Word = get(s,'Words');

% get Sentences
Sen = get(s, 'Sentences');

% get the number of each phonemes
tmp = SpeechEvents(s,'Phonemes','list');





