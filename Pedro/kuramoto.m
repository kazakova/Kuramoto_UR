function [T,Y] = kuramoto(ic,adj,w,tSpan)

    % param{1} = number of nodes
    % param{2} = adjacency matrix
    % param{3} = natural frequencies
    %number of oscillators
    param{1} = size(ic,1);
    param{2} = adj;
    param{3} = w;
    
    [T Y] = ode45(@(t,y) odeKur(t,y,param),tSpan,ic);
    %[T Y] = ode113(@(t,y) odeKur(t,y,param),tSpan,ic);
    
end % end kuramoto
