% function genoDriver(InputFile,OutputFile)
 
% test
clc
close all
clear
InputFile='geno.txt';
OutputFile='genout.txt';
 
%% Open File
fin=fopen(InputFile,'r');
fout=fopen(OutputFile,'w+');
 
%% Definition
PI2=6.28318530717959;
ar = 0.1;  ai = 0.12;    % paramters in (9) in the paper 
tr = -0.3; ti = -0.2;
cr = 0;    ci = 0;
gr = 0.45; gi = -0.19;
 
%Fill Array with 0's
for i=1:9000
    ua(i) = 0;
    ut(i) = 0;
    uc(i) = 0;
    ug(i) = 0;
end

for i=1:1024
    x(i)=0;
end
 
disp('============================================================================');
disp('Copy Right of Justin Bi.');
disp('Program by Justin Bi, Aug 2013. All rights reserved.');
disp('============================================================================');
 
% Read the Input File
[InputData, Size]=fscanf(fin,'%s'); %Ignore the blank
fclose(fin);
n_lines = 0;
k = 1;
n = 1;
DataLength = length(InputData);
if(DataLength>(60*140))
    DataLength=8400; %only read 60*140=8400
    n_lines=DataLength/60;
end
n_lines = round(DataLength/60);
for i=1:DataLength % read 1 line at a time, save it in character string s
    if(InputData(i)=='a')
        ua(k) = 1;
        k = k + 1;
    elseif(InputData(i)=='t')
        ut(k) = 1;
        k = k + 1;
    elseif(InputData(i)=='c')
        uc(k) = 1;
        k = k + 1;
    elseif(InputData(i)=='g')
        ug(k) = 1;
        k = k + 1;
    else
        % nothing
    end
end
disp(strcat('read-',num2str(n_lines),' lines from input File with-',num2str(k-1),' characters'));
 
%% Begins DFT from FFT
for i=1:8000
    for j=1:351
        x(2*j-1) = ua(j+i-1);              % put Ua(1) ... Ua(351) into x, remember real goes to even and imaginary goes to odd
        x(2*j) = 0;
    end
    for j=352:512                          % pads the rest of the array using perioic padding
        x(2*j-1) = ua(j+i-352);
        x(2*j) = 0;
    end
    for j=1:512
        y(j)=complex(x(2*j-1),x(2*j));
    end
    z=fft(y,512);
    aa = real(z(171));
    aai = imag(z(171));
    
    for j=1:351
        x(2*j-1) = ut(j);                  % put Ua(1) ... Ua(351) into x, remember real goes to even and imaginary goes to odd
        x(2*j) = 0;
    end
    for j=352:512                          % pads the rest of the array using perioic padding
        x(2*j-1) = ut(j+i-352);
        x(2*j) = 0;
    end
    for j=1:512
        y(j)=complex(x(2*j-1),x(2*j));
    end
    z=fft(y,512);
    tt = real(z(171));
    tti = imag(z(171));
 
    for j=1:351
        x(2*j-1) = uc(j);                  % put Ua(1) ... Ua(351) into x, remember real goes to even and imaginary goes to odd
        x(2*j) = 0;
    end
    for j=352:512                          % pads the rest of the array using perioic padding
        x(2*j-1) = uc(j+i-352);
        x(2*j) = 0;
    end
    for j=1:512
        y(j)=complex(x(2*j-1),x(2*j));
    end
    z=fft(y,512);
    cc = real(z(171));
    cci = imag(z(171));
 
    for j=1:351
        x(2*j-1) = ug(j);                  % put Ua(1) ... Ua(351) into x, remember real goes to even and imaginary goes to odd
        x(2*j) = 0;
    end
    for j=352:512                          % pads the rest of the array using perioic padding
        x(2*j-1) = ug(j+i-352);
        x(2*j) = 0;
    end
    for j=1:512
        y(j)=complex(x(2*j-1),x(2*j));
    end
    z=fft(y,512);
    gg = real(z(171));
    ggi = imag(z(171));
    
    % Equation Declarations for Optimized and Unoptimized
    Ar = ar*aa-ai*aai; Ai = ar*aai+ai*aa;
    Tr = tr*tt-ti*tti; Ti = tr*tti+ti*tt;
    Cr = cr*cc-ci*cci; Ci = cr*cci+ci*cc;
    Gr = gr*gg-gi*ggi; Gi = gr*ggi+gi*gg;
    
    tempr = Ar+Tr+Cr+Gr;
    tempi = Ai+Ti+Ci+Gi;
    % Optimized Equation Calculations
    temp = tempr*tempr+tempi*tempi;
    fprintf(fout,'%f \t', temp);
    %Unoptimized Equation Calculations
    temp = aa*aa+aai*aai+tt*tt+tti*tti+cc*cc+cci*cci+gg*gg+ggi*ggi;
    fprintf(fout,'%f \t', temp);
   
   %% Begins DFT from definition
   
   % performs the standard DFT
   % equations for aa, aai, cc, cci, etc follow formula for DFT
   aa = 0; aai = 0;
   for j=1:315
   aa = aa+ ua(j+i-1)*cos(PI2*(j-1)/3.0);
   aai = aai -ua(j+i-1)*sin(PI2*(j-1)/3.0);
   end
 
   tt = 0; tti = 0;
   for j=1:315
      tt = tt+ ut(j+i-1)*cos(PI2*(j-1)/3.0);
      tti = tti-ut(j+i-1)*sin(PI2*(j-1)/3.0);
   end
   
   cc = 0; cci = 0;
   for j=1:315
      cc = cc+ uc(j+i-1)*cos(PI2*(j-1)/3.0);
      cci = cci -uc(j+i-1)*sin(PI2*(j-1)/3.0);
   end
   
   gg = 0; ggi = 0;
   for j=1:315
      gg = gg+ ug(j+i-1)*cos(PI2*(j-1)/3.0);
      ggi = ggi -ug(j+i-1)*sin(PI2*(j-1)/3.0);
   end
   
   % exp(-j2pi*m/3)=cos(j2p*m/3)-jsin(j2pi*m/3), so minus sign for img part
   aa=aa/315; aai=aai/315;
   tt=tt/315; tti=tti/315;
   cc=cc/315; cci=cci/315;
   gg=gg/315; ggi=ggi/315;
 
   % Equation Declarations for Optimized and Unoptimized
   Ar = ar*aa-ai*aai; Ai = ar*aai+ai*aa;
   Tr = tr*tt-ti*tti; Ti = tr*tti+ti*tt;
   Cr = cr*cc-ci*cci; Ci = cr*cci+ci*cc;
   Gr = gr*gg-gi*ggi; Gi = gr*ggi+gi*gg;
 
   tempr = Ar+Tr+Cr+Gr;
   tempi = Ai+Ti+Ci+Gi;
   % Optimized Equation Calculations
   temp = tempr*tempr+tempi*tempi;
   fprintf(fout,'%f \t', temp);
   % Unoptimized Equation Calculations
   temp = aa*aa+aai*aai+tt*tt+tti*tti+cc*cc+cci*cci+gg*gg+ggi*ggi;
   fprintf(fout,'%f \n', temp);         
   
   if (mod(i,1000) == 0)
      disp(strcat('processed-',num2str(i),'-lines'));   
   end
end
fclose(fout);