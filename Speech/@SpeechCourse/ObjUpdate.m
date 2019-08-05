function o = ObjUpdate (o)
%
% This function recalculate and update the fields of speech class.

% Nima Mesgarani, Columbia University, nima@ee.columbia.edu

Subsets = get(o,'Subsets');

 

load Subset1 

load Subset2 

load Subset3 

load Subset4 

load Subset5;

% Define the filenames for different subsets:

Subset{1} = Subset1;

Subset{2} = Subset2;

Subset{3} = Subset3;

Subset{4} = Subset4;

Subset{5} = Subset5;
%%%%%%%%%%%%%
%
object_spec = what('SpeechCourse');
soundpath = [object_spec.path filesep 'Sounds'];
Names = [];
PreStim = get(o,'PreStimSilence');
if ~isempty(Subsets) & (length(get(o,'Names'))~=1)
    for cnt1 = 1:length(Subset)  % check all subsets:
        if ~isempty(find(Subsets==cnt1))  % User requested this subset, add it to the names:
            Names = [Names Subset{cnt1}];
        end
    end
else
    Names = get(o,'Names');
end
Phonemes = {};
Words = {};
Sentences = {};
Formants = {}; 
Pitch = {};
if ~isempty(Names)
%     fs =get(o,'samplingRate'); % since all the files have the same sampling frequency.
    % Now, add phonemes, words and sentences:
    for cnt1 = 1:length(Names)
        if strfind(Names{cnt1},'.wav')
            [Samples, fs] = audioread([soundpath filesep Names{cnt1}]);
        else
            [Samples, fs] = audioread([soundpath filesep Names{cnt1} '.wav']);
        end
        % first, phonemes:
        ph = [];
        f = fopen([soundpath filesep Names{cnt1} '.phn'],'r');
        s = fgetl(f);
        while s~=-1
            spaces = strfind(s,' ');
            ph(end+1).Note = strrep(s(spaces(2):end),' ','');
            ph(end).Note   = strrep(ph(end).Note, '''', '"');
            ph(end).StartTime = PreStim + str2num(s(1:spaces(1))) / fs;
            ph(end).StopTime = PreStim + str2num(s(spaces(1):spaces(2))) / fs;
            if ph(end).StopTime > (PreStim+(length(Samples)/fs)) break;end
            s = fgetl(f);
        end
        fclose(f);
        % second, words:
        wr = [];
        f = fopen([soundpath filesep Names{cnt1} '.wrd'],'r');
        s = fgetl(f);
        while s~=-1
            spaces = strfind(s,' ');
            wr(end+1).Note = strrep(s(spaces(2):end),' ','');
            wr(end).Note   = strrep(wr(end).Note, '''', '"');
            wr(end).StartTime = PreStim + str2num(s(1:spaces(1))) / fs;
            wr(end).StopTime = PreStim + str2num(s(spaces(1):spaces(2))) / fs;
            if wr(end).StopTime>(PreStim+(length(Samples)/fs)) break;end
            s = fgetl(f);
        end
        fclose(f);
        % and last, the sentece:
        f = fopen([soundpath filesep Names{cnt1} '.txt'],'r');
        s = fgetl(f);
        fclose(f);
        spaces = strfind(s,' ');
        se.Note = s(spaces(2)+1:end);
        se.Note = strrep(se.Note, '''', '"');
        se.StartTime = [];
        se.StopTime = [];
        % formants;
        f = [soundpath filesep  Names{cnt1} '.frm'];
        frm = load(f);
        frm = [zeros(2+PreStim*100,size(frm,2)); frm];
        % pitch
        f = [soundpath filesep Names{cnt1} '.f0'];
        f0 = load(f);
        f0 = [zeros(PreStim*100,size(f0,2)); f0];
        %%
        Phonemes{cnt1} = ph;
        Words{cnt1} = wr;
        Sentences{cnt1} = se;
        Formants{cnt1} = frm;
        Pitch{cnt1} = f0;
    end
end
o = set(o,'Names',Names);
o = set(o,'Phonemes',Phonemes);
o = set(o,'Words',Words);
o = set(o,'Sentences',Sentences);
o = set(o,'Formants',Formants);
o = set(o,'Pitch',Pitch);
o = set(o,'MaxIndex', length(Names));
