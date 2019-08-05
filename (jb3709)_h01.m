clear all
close all

% Problem 1
n = -30:30;
N = 60;
x1 = sin(6*(n)*pi/N)+pi/6;
x2 = exp(1j*6*(n)*pi/N);
x3 = sqrt(3)/2*imag(x2) + 1/2*real(x2);

figure;
subplot(2,3,1);
    plot(n,x1);
    title('x1');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,2);
    plot(n,real(x2));
    title('Real x2');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,3);
    plot(n,imag(x2));
    title('Imaginary x2');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,4);
    plot(n,abs(x2));
    title('Magnitude x2');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,5);
    plot(n,angle(x2));
    title('Phase x2');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,6);
    plot(n,x3);
    title('x3');
    xlabel('n');
    ylabel('x[n]');

% Problem 2
% 31 = 0
x1 = sin(6*(n)*pi/N)+pi/6;
h1=zeros(1,61);
h2=zeros(1,61);
h3=zeros(1,61);
sigma = 1.2;
for n1=33:39
    h1(n1)=1;
end
h2(31) = 1;
h2(32) = -1;
for n3 = 21:41
h3(n3) = exp(-(n3-31)*(n3-31)/(2*sigma*sigma));
end

new = -60:60;

y11 = conv(x1,h1);
y12 = conv(x1,h2);
y13 = conv(x1,h3);

figure;
subplot(2,3,1);
    stem(n,h1);
    title('h1');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,4);
    stem(new,y11);
    title('y11');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,2);
    stem(n,h2);
    title('h2');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,5);
    stem(new,y12);
    title('y12');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,3);
    stem(n,h3);
    title('h3');
    xlabel('n');
    ylabel('x[n]');
subplot(2,3,6);
    stem(new,y13);
    title('y13');
    xlabel('n');
    ylabel('x[n]');