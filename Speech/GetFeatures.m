function phoneme_data = GetFeatures(s, phoneme, feat, param)
% function phoneme_data = ECogFormantPitchPhoneme(s, phoneme)
% phoneme_data is a structure for each instance of the phoneme
% fields: formant, pitch

if ~exist('param','var')
    bef = 0; aft = 0;
else
    bef = param(1); aft = param(2);
end
tmp = what(class(s));
tmp = [tmp.path filesep 'sounds' filesep];
lst = SpeechEvents(s,'phonemes','list');
idx = find(ismember({lst.Note}, phoneme));
phn = SpeechEvents(s,'phonemes',lst(idx).Note);
num_phn = length(phn);
phoneme_data = phn;
PreStim = get(s,'PreStimSilence');
srate = 100; %sampling rate

for i_phn = 1:num_phn
    % calculate start, stop index
    start = ceil((phn(i_phn).StartTime-PreStim-bef) * srate);
    stop  = ceil((phn(i_phn).StopTime -PreStim+aft) * srate);
    %     if stop > min(length(f0),length(fm))
    %         stop = min(length(f0), length(fm));
    %     end
    timepts = [start stop];
    switch lower(feat)
        case {'formant','formant_transition'}
            % load data files
            fm =  load([tmp phn(i_phn).Note '.frm']);
            % extract formants and pitch at specified timepoints
            fmdata = fm(timepts(1)-2:min(size(fm,1),timepts(2)-2), 1:4);
            phoneme_data(i_phn).feat = fmdata;
        case 'pitch'
            f0 = load([tmp phn(i_phn).Note '.f0']);
            f0data = f0(timepts(1):timepts(2), 1);
            phoneme_data(i_phn).feat = f0data;
        case {'vot','dur'}
            phoneme_data(i_phn).feat = (phn(i_phn).StopTime-phn(i_phn).StartTime)*srate;
        case 'spectroid'
            rep = GetRepresentation(s,'melfilterlog',phn(i_phn).Trial);
            rep = rep(:,round(100*(phn(i_phn).StartTime):100*(phn(i_phn).StopTime)));
            rep = mean(rep,2);
            phoneme_data(i_phn).feat = (rep/sum(rep))'*(1:24)';
        case {'specpeak','spectilt'}
            aud = 'melfilterlog';
%             aud = 'cfcc';
            rep = GetRepresentation(s,aud,phn(i_phn).Trial);
            d = fspecial('disk',3);
            rep = conv2(rep,d(:,2),'same');
            ind = round(100*(phn(i_phn).StartTime):100*(phn(i_phn).StopTime)-0);
            if isempty(ind),
                ind = round(100*(phn(i_phn).StartTime):100*(phn(i_phn).StopTime-0));
            end
            rep2 = rep(:,ind);
            if 0
                subplot(3,1,1);
                imagesc(rep);axis xy;
                line([ind(1) ind(1)],[0 20],'linewidth',2);
                line([ind(2) ind(2)],[0 20],'linewidth',2);
                LabelAxis(s,gca,phn(i_phn).Note);
                subplot(3,1,2);
                imagesc(rep);axis xy;
                subplot(3,10,21:22);
                imagesc(rep2);axis xy;
                %             rep = rep(:,ceil(size(rep,2)/2));
                %             rep = rep.*repmat(hamming(size(rep,2)).^.1,[1 size(rep,1)])';
            end
            rep2 = max(rep2(:,1:end),[],2);
            if strcmpi(feat,'specpeak')
                %             rep2 = median(rep2(:,1:end),2);
%                 [t1,ti] = max(rep2);
                ti = rep2'*(1:24)'/sum(rep2);
            else
                tmp = dct(rep2); 
                ti = -tmp(2);
%                 ti = rep2'*(-12:11)'/sum(rep2);
%                 ti = skewness(rep2,0);
            end
            %             ti = (1:24) * rep2;
            %             disp(ti);
            phoneme_data(i_phn).feat = ti;
        case 'antiformant'
            rep = GetRepresentation(s,'melfilterlog',phn(i_phn).Trial);
            rep = rep(:,round(100*(phn(i_phn).StartTime):100*(phn(i_phn).StopTime)));
            %             rep = rep(:,ceil(size(rep,2)/2));
            %             rep = rep.*repmat(hamming(size(rep,2)).^.1,[1 size(rep,1)])';
            imagesc(rep);axis xy
            rep = min(rep(:,1:end),[],2);
            ti = find(peakpick(-rep));
            ti(end+1:4) = NaN;
            ti(5:end) = [];
            phoneme_data(i_phn).feat = ti;
        case 'f2-onset'
            fm =  load([tmp phn(i_phn).Note '.frm']);
            f2onset  = fm(timepts(2)-1:min(size(fm,1),timepts(2)+0), 2);
            f2onset  = fm(timepts(2)-1:min(size(fm,1),timepts(2)+1), 2);
            phoneme_data(i_phn).feat = mean(f2onset);
            
        case 'f2-middle'
            fm =  load([tmp phn(i_phn).Note '.frm']);
            %             hold off;
            %             plot(fm(timepts(2)-1:timepts(2)+8,2),'.-');
            %             line([
            % extract formants and pitch at specified timepoints
            f2middle = fm(timepts(2)+2:min(size(fm,1),timepts(2)+5), 2);
            phoneme_data(i_phn).feat = mean(f2middle);
            %             hold on;
            %             plot([1,4],[mean(f2onset) mean(f2middle)],'r*');
            2;
        otherwise
            disp(['Unknown feature specified: ' feat]);
    end
end