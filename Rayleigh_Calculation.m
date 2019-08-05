% http://www.edaboard.com/thread71584.html

function [c t]=Rayleigh_Calculation(fd)
So=16;										%Number of paths
Fs=1000;
Ts=1/Fs;
tstart=0;
tend=2;
t=[tstart:Ts:tend];
wm=2*pi*fd;								%Maximum shift
fm=wm/(2*pi);							%Doppler shift
S=2*(2*So+1);
Xco=(1.414*cos(wm*t));
Xso=0;
sum1=0;
sum2=0;
for n=1:So
   A(n)=(2*pi*n)/S;					%Azimuthal angles
   wn(n)=wm*cos(A(n));
   O(n)=(pi*n)/(So+1);
  sum1=sum1+(cos(O(n)).*cos(wn(n)*t));
     sum2=sum2+(cos(wn(n)*t).*sin(O(n)));
end
Xc=2*sum1+Xco;
Xs=2*sum2+Xso;
c=(1/sqrt(2*So+1))*(Xc+j*Xs);