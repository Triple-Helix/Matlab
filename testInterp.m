function y = testInterp(x,xi,yi)
    if x < xi(1)
        y = yi(1)*(x)/(xi(1));
    elseif x > xi(length(xi))
        y = yi(length(xi)) + (x-xi(length(xi)))*(yi(length(xi))-yi(length(xi)-1))/((xi(length(xi))-xi(length(xi)-1)));
    else
        for i = 1:length(xi)-1
            if x > xi(i) && x <= xi(i+1)
                x1 = xi(i); x2 = xi(i+1);
                y1 = yi(i); y2 = yi(i+1);
            end
        end
        y = y1 + (y2-y1)*((x-x1)/(x2-x1));
    end
end