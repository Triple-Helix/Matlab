clear all
close all

s = SpeechCourse;

indMale = 1;
indFem  = 4;

waveMale = waveform(s, indMale);
waveFem  = waveform(s, indFem);

FFTMale = fft(waveMale);
FFTFem  = fft(waveFem);

d1 = fdesign.lowpass('Fp,Fst,Ap,Ast', 500, 550, 0.5, 60, 16000);
Hd1 = design(d1);
LPFMale1 = filter(Hd1, waveMale);
LPFFem1  = filter(Hd1, waveFem);

d2 = fdesign.lowpass('Fp,Fst,Ap,Ast', 1000, 1100, 0.5, 60, 16000);
Hd2 = design(d2);
LPFMale2 = filter(Hd2, waveMale);
LPFFem2  = filter(Hd2, waveFem);

d3 = fdesign.lowpass('Fp,Fst,Ap,Ast', 2000, 2100, 0.5, 60, 16000);
Hd3 = design(d3);
LPFMale3 = filter(Hd3, waveMale);
LPFFem3  = filter(Hd2, waveFem);
% using soundsc(LPFMale, 16000) I could hear that as the cutoff freq. (Fc) 
% increased, the sound became better. Worst one at lowest Fc.

downMale = waveMale(1:4:end);
downFem  = waveFem(1:4:end);
% the downsampled versions of the original waves sound much worse.
% soundsc(downMale,4000)

deciMale = zeros(1,26522);
for i = 1:26522
    if mod(i,4)==0
        deciMale(i) = waveMale(i);
    end
    if mod(i,4)~=0
        deciMale(i) = 0;
    end
end
deciFem  = zeros(1,26522);
for i = 1:26522
    if mod(i,4)==0
        deciFem(i) = waveFem(i);
    end
    if mod(i,4)~=0
        deciFem(i) = 0;
    end
end
% the decimated versions of the original waves sound much worse.
% soundsc(deciMale,16000)

figure(1)
plot(waveMale)
title('Waveform Male')

figure(2)
plot(waveFem)
title('Waveform Female')

figure(3)
plot(abs(FFTMale))
title('FFT Male')

figure(4)
plot(abs(FFTFem))
title('FFT Female')