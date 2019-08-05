function y = delay(x,mt)
    y = zeros(1,length(x));
    for n = 1:mt
        y(n) = 0;
    end
    for m = mt+1:length(x)
        y(m) = x(m-mt);
    end
    y = y';
end

