function [ ] = mono_receiver(inputFile,outFile,flag)
[y, Fs, Nbit] = wavread(inputFile);
[m,n] = size(y);
load DemodFilter.mat
h = hImpResp;
z1 = zeros(m,1);
w=15000;
if flag == 1
for i=1:m
    z1(i)=y(i)*2*cos(w*i);
end
end
x1 = conv((y + z1),h);
x2 = conv((y - z1),h);
y=[x1,x2];
wavwrite(y,Fs,outFile);
end