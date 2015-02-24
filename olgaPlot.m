%%function olgaPlot
%Theta - matrix of thetas colums - values of theta at a give time step
%the number of colums equal the number of time steps
%time - column!!! vector of time

function olgaPlot(theta, time)
[counts,centers] = hist(theta);
figure(1);
bar3(counts);
xlabel('time');
ylabel('phase from 0 - 2*pi');
zlabel('count');
tick = get(gca,{'XTick','YTick'});

%for each time lot find mean theta and standard deviation
figure(2);
stdTheta = std(theta);
timeVector = time';
%errorbar(timeVector, meanTheta, meanTheta)
plot(time, stdTheta);
xlabel('time');
ylabel('std of phase');