function o = SpeechCourse(varargin)
%
% properties:
%   PreStimSilcence
%   PostStimSilence
%   SamplingRate
%   Loudness
%   Subsets: 1..4
%   Phonemes: contains the phoneme events for the specified names.
%   Words: contains the word events for the specified names.
%   Sentences: contains the sentece events for the specified names.
% 
% methods: waveform, LabelAxis, set, get
% 

% Nima Mesgarani, Columbia University, nima@ee.columbia.edu

switch nargin
case 0
    % if no input arguments, create a default object
    s = SoundObject ('SpeechCourse', 16000, 0, 0, 0, {}, 1, {'Subsets','edit',1,'SNR','edit',1000,...
        'NoiseType','popupmenu','None|White|Pink|Jet2|F16|MachineGun|City|SpectSmooth','ReverbTime','edit',0,...
        'Duration','edit',3});
    o.Subsets = [1];
    o.SNR = 1000;
    o.NoiseType = 'White';
    o.ReverbTime = 0;
    o.Phonemes = {struct('Note','','StartTime',0,'StopTime',0)};
    o.Words= {struct('Note','','StartTime',0,'StopTime',0)};    
    o.Sentences = {''};
    o.Duration = 3;
    o.Formants = [];
    o.Pitch = [];
    o = class(o,'SpeechCourse',s);
    o = ObjUpdate (o);
case 1
    % if single argument of class SoundObject, return it
    if isa(varargin{1},'SpeechCourse')
        o = varargin{1};
    else
        error('Wrong argument type');
    end
case 7
    s = SoundObject('SpeechCourse', ...
        varargin{1}, ...    % SamplingFrequency
        varargin{2}, ...    % Loudness
        varargin{3}, ...    % PreStimSilence
        varargin{4},...     % PostStimSilence
        '',...              % Names
        1,{'Subsets','edit',1,'SNR','edit',1000,'Duration','edit',3});
    o.Subsets   = varargin{5};
    o.SNR       = varargin{6};
    o.Duration  = varargin{7};
    o.Phonemes = {struct('Note','','StartTime',0,'StopTime',0)};
    o.Words= {struct('Note','','StartTime',0,'StopTime',0)};    
    o.Sentences = {''};
    o = class(o,'ECSpeech',s);
    o = ObjUpdate (o);

    %%
otherwise
    error('Wrong number of input arguments');
end