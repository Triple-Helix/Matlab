load ECELab1BPFreq.txt;
load ECELab1BPGain.txt;

ExFreq = ECELab1BPFreq';
ExFreq = log(ExFreq);
ExGain = ECELab1BPGain';

ThFreq = 2.*pi.*[100:1000000];
ThFreq = log(ThFreq);
w = 2.*pi.*ThFreq;
w0 = 1/sqrt(L*C);
Q = R*C*w0;
a = (w./w0)-(w0./w);
b = (Q.^2) .* (a.^2);
G = 1./sqrt(1+b); %Convert to Decibels

%figure
%plot(ExFreq,ExGain,'rx');
%hold on
plot(ThFreq,ThGain,'b');
%hold off

title('Low Pass Gain vs. Frequency');
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');