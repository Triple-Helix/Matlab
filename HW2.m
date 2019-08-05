clear all
r = 1; %Radius
w = 1; %Width of wheel base
x = [0; 0; 0]; %Starting position
xd = [1; 1; (pi/4)]; %Ending position
deltat = 0.01;
t = 0:0.01:1;
c0 = [1; 1; 1; 1];

c = c0;
xc = x;
index = 1; %index for storing final xc and dx values


while (norm(xd-xc) >= 0.1)
    x1 = x; 
    xc = x; 
    %Calculate f(c)
    for j=1:1:100
        dphi = [c(1)+2*c(3)*t(j); c(2)+2*c(4)*t(j)];
        A = [r/2*cos(x1(3)), r/2*cos(x1(3)); 
             r/2*sin(x1(3)), r/2*sin(x1(3)); 
             -r/w, r/w];
        dx = A*dphi;
        x1 = x1 + deltat.*dx;        
    end
    xc = x + x1;
   
    %Calculate delta x
    deltax = ((xd - xc).*deltat)./norm((xd-xc));

    %Calculate df/dc1
    x1 = x;
    c1 = c + deltat*[1; 0; 0; 0];
    for j=1:1:100
        dphi1 = [c1(1)+2*c1(3)*t(j); c1(2)+2*c1(4)*t(j)];
        A1 = [r/2*cos(x1(3)), r/2*cos(x1(3)); r/2*sin(x1(3)), r/2*sin(x1(3)); -r/w, r/w];
        dx1 = A1*dphi1;
        x1 = x1 + deltat.*dx1;
    end
    dc1 = x + x1;
    dfdc1 = (1./deltat).*(dc1-xc);
    
    %Calculate df/dc2
    x1 = x;
    c2 = c + deltat*[0; 1; 0; 0];
    for j=1:1:100
        dphi2 = [c2(1)+2*c2(3)*t(j); c2(2)+2*c2(4)*t(j)];
        A2 = [r/2*cos(x1(3)), r/2*cos(x1(3)); r/2*sin(x1(3)), r/2*sin(x1(3)); -r/w, r/w];
        dx2 = A2*dphi2;
        x1 = x1 + deltat.*dx2;
    end
    dc2 = x + x1;
    dfdc2 = (1./deltat).*(dc2-xc);
    
    %Calculate df/dc3
    x1 = x;
    c3 = c + deltat*[0; 0; 1; 0];
    for j=1:1:100
        dphi3 = [c3(1)+2*c3(3)*t(j); c3(2)+2*c3(4)*t(j)];
        A3 = [r/2*cos(x1(3)), r/2*cos(x1(3)); r/2*sin(x1(3)), r/2*sin(x1(3)); -r/w, r/w];
        dx3 = A3*dphi3;
        x1 = x1 + deltat.*dx3;
    end
    dc3 = x + x1;
    dfdc3 = (1./deltat).*(dc3-xc);
    
    %Calculate df/dc4
    x1 = x;
    c4 = c + deltat*[0; 0; 0; 1];
    for j=1:1:100
        dphi4 = [c4(1)+2*c4(3)*t(j); c4(2)+2*c4(4)*t(j)];
        A4 = [r/2*cos(x1(3)), r/2*cos(x1(3)); r/2*sin(x1(3)), r/2*sin(x1(3)); -r/w, r/w];
        dx4 = A4*dphi4;
        x1 = x1 + deltat.*dx4;
    end
    dc4 = x + x1;
    dfdc4 = (1./deltat).*(dc4-xc);
    
    %Constructing the Jacobian
    J = [dfdc1, dfdc2, dfdc3, dfdc4];
    
    %Calculating delta c
    deltac = (pinv(J))*deltax;
    
    %Update
    c = c + deltac;
    xcf(:, :, index) = xc; %Stores xc values for each iteration
    index = index + 1;
    
    %disp(x1);
end

%Plot trajectories
elements = length(xcf);
figure(1)
for i = 1:floor((elements)/20):elements
      xf = xcf(:, :, i);
      
      xend = xf(1) + 0.1*sin(xf(3));
      yend = xf(2) + 0.1*cos(xf(3));
      x = [xf(1), xend];
      y = [xf(2), yend];
      plot(x, y);      
end
xf = xcf(:,:, elements);

xend = xf(1) + 0.1*sin(xf(3));
yend = xf(2) + 0.1*cos(xf(3));
x = [xf(1), xend];
y = [xf(2), yend];
plot(x, y);