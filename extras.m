%% phase over every oscillator over time
% bar3(theta);
% xlabel('time');
% ylabel('indivitual oscillators');
% zlabel('phase');
%% check
% ThMatrix = Th * ones(1, N)
% DiffMatrix = ThMatrix'-ThMatrix
% SinOfDiff = sin(DiffMatrix)
% SinOfDiff1 = SinOfDiff.*K
% SinOfDiff2 = K.*SinOfDiff
% SumOfSin = sum(SinOfDiff, 2)
% rhs = W + SumOfSin/N

%% hist over time
% [counts,centers] = hist(theta);
% bar3(counts);
% xlabel('time');
% ylabel('phase from 0 - 2*pi');
% zlabel('count');
% tick = get(gca,{'XTick','YTick'});
% ytic = 0:(2*pi/5):2*pi;
% set(gca,'YTickLabel',ytic);

%% movie
% thetaCos = cos(theta);
% thetaSin = sin(theta); 
% for i = 1 : size(theta, 1)
%     plot(thetaCos(i,:), thetaSin(i, :), 'ok')
%     axis([-1.5 1.5 -1.5 1.5]);
%     pause(0.1);
% end;

%% std vs time
% %for each time lot find mean theta and standard deviation
% stdTheta = std(theta);
% timeVector = time';
% %errorbar(timeVector, meanTheta, meanTheta)
% plot(time, stdTheta);
% xlabel('time');
% ylabel('std of phase');