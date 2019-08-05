function [ ] = transmitter(inputFile,outFile)
[Stereo_Sound, Fs, Nbit] = wavread(inputFile);
[m,n] = size(Stereo_Sound);
y = zeros(m,1);
w = 15000;
Left_Channel = Stereo_Sound(:,1);
Right_Channel = Stereo_Sound(:,2);
for i=1:m
      y(i) = Right_Channel(i) + Left_Channel(i) + (Right_Channel(i) - Left_Channel(i))*cos(w*i);
end
wavwrite(y,Fs,outFile);
end