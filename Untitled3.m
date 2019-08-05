for d = 1:1000;
    q1(d) = 1-qfunc(-112);
    q2(d) = qfunc(-118);
end

plot(q1);