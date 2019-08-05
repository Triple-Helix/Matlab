function PL = Wireless431(dist,freq,n,sigma,d0,samples)
    lambda = 3e8/freq;

    PL0 = 20*log10(4*pi*d0/lambda);
    
    PL = zeros(samples,1);
    for d = 1:samples
        Xi = normrnd(0,sigma);
        PL(d) = PL0 + 10*n*log10(dist/d0)+Xi;
    end
end