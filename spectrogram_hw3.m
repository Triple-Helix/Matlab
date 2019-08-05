function [s,f,t]=spectrogram_hw3(x,fs,wintime,steptime)
        %x: signal
        %fs: samplping frequency in Hz
        %wintime: window time in milli seconds
        %steptime: hop time in milli seconds

        winpts = round(wintime*fs);
        steppts = round(steptime*fs);

        nfft = 2^(ceil(log(winpts)/log(2)));
        window = hamming(winpts);
        noverlap = winpts - steppts;
        Fs = fs;

        nx = length(x);
        nwind = length(window);
        if nx < nwind    % zero-pad x if it has length less than the window length
            x(nwind)=0;  nx=nwind;
        end
        x = x(:); % make a column vector for ease later
        window = window(:); % be consistent with data set

        ncol = fix((nx-noverlap)/(nwind-noverlap));
        colindex = 1 + (0:(ncol-1))*(nwind-noverlap);
        rowindex = (1:nwind)';
        if length(x)<(nwind+colindex(ncol)-1)
            x(nwind+colindex(ncol)-1) = 0;   % zero-pad x
        end

        y = zeros(nwind,ncol);

        % put x into columns of y with the proper offset
        % should be able to do this with fancy indexing!
        y(:) = x(rowindex(:,ones(1,ncol))+colindex(ones(nwind,1),:)-1);

        % Apply the window to the array of offset signal segments.
        y = window(:,ones(1,ncol)).*y;


        % now fft y which does the columns
        y = fft(y,nfft);
        if ~any(any(imag(x)))    % x purely real
            if rem(nfft,2),    % nfft odd
                select = 1:(nfft+1)/2;
            else
                select = 1:nfft/2+1;
            end
            y = y(select,:);
        else
            select = 1:nfft;
        end
        f = (select - 1)'*Fs/nfft;

        t = (colindex-1)'/Fs;

        s=abs(y).^2;
    end