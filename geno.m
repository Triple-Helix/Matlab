function [ ] = geno(data, nn, isign ) % data is an array
%Fourier Transform Function of nn points
%   @param array holds all values of the points (even is real, odd is img)
%   @param number of points in the FT
%   @param FT if 1, inv FT if -1
%   @return void

clear all;
close all;
n = nn << 1;
j = 1;

for i=1:2:n
    if(j>1)
        x = data(j);
        y = data(i);
        data(j) = y;
        data(i) = x;
        
        a = data(j+1);
        b = data(i+1);
        data(j+1) = b;
        data(i+1) = a;
    end
    m = n;
    while(m>=2 && j>m)
        j = j - m;
        m >>= 1;
    end
    j = j + m;
end

mmax = 2;

while (n > max)
    istep = 2*mmax;
    theta=6.28318530717959/(isign*mmax);
    wtemp=sin(0.5*theta);
	wpr = -2.0*wtemp*wtemp;
	wpi=sin(theta);
	wr=1.0;
	wi=0.0;
    for m=1:2:mmax
        for i=m:istep:n
            j = i+mmax;
			tempr = wr*data(j)-wi*data(j+1);
			tempi = wr*data(j+1)+wi*data(j);
			data(j) = data(i)-tempr;
			data(j1) = data(i+1)-tempi;
			data(i) = data(i) + tempr;
			data(i+1) = data(i+1) + tempi;
        end
        wr = (wtemp+wr)*wpr-wi*wpi+wr;
        wi = wi*wpr+wtemp*wpi+wi;
    end
    mmax = istep;
end