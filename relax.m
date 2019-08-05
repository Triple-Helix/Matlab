clear all; % clears all the existing variables from memory
% three lines below set up the 2-D spatial grid
x=[-10:0.5:10]; % range of x values
y=[-10:0.5:10]; % range of y values
[X,Y]=meshgrid(x,y); % mesh the grid
% set boundaries
V=X.*0; % initialize all points to zero
% four boundary conditions below
V(1,:)=x.*0-3;
V(length(y),:)=3.*sin(x);
V(:,1)=y'.*0+1;
V(:,length(x))=y'.*0+3;
Vnew=V; % initialize Vnew
% perform relaxation
m=0;
cond=1;
while(cond>0.001)
    m=m+1;
    for i=2:(length(y)-1)
        for j=2:(length(x)-1)
            Vnew(i,j)=(1./4).*(Vnew(i-1,j)+V(i+1,j)+Vnew(i,j-1)+V(i,j+1));
            if((x(j)*x(j)+y(i)*y(i))<4) %add a circle in the space
            Vnew(i,j) = -1;
            end
        end
    end
    cond=max(max(abs(V-Vnew))) % calculate maximum change of any point
    e(m)=cond;
    %V=Vnew; % change this line for over/under relaxation
    %V=V*(.25) + Vnew*(.75) %Under
    V=V*(-.5) + Vnew*(1.5) %Over
    % plot current field
    surf(x,y,V);
    M(m)=getframe(gcf);
    % just in case it doesnt converge we need an out
    if(m>1000)
        cond=0;
        message='too many iterations'
    end
end
m
figure;
semilogy(e)