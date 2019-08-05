[y,Fs] = audioread('Immortals.mp3');

start = Fs*40;
last = length(y)-10*Fs;

yNew = zeros(last-start,2);

for i=start:last
    yNew(i,1) = y(i,1);
    yNew(i,2) = y(i,2);
end

% audiowrite('newImmortals.mp3', yNew, Fs);