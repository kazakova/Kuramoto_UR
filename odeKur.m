function dy = odeKur(t,y,param)

    % dy = change in phase
    % y  = phase
    
    % dy = w + sum over j (k/n * sin(y(j) - y(i)))
    r = repmat(y,1,param{1});
    dy = param{3} + sum(param{2} .* sin(r'-r),2);
    
end % end ode