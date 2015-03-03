
close all; clear all; clc;
%% algorythm
% %number of oscilators in each community
% N = 30;
% NumComm = 2;
% totalN = NumComm*N;

%time span
T = 5;
%number communities and number of oscilators in them
minmemb = 30;
maxmemb = 60;
N = 2;%number of communitites
NumMemb = zeros(1, N);
for i = 1 : N
    NumMemb(i) = randi([minmemb maxmemb]);
end;

%natural frequency for communities with random mean between 1 and 4
globalW = [];
for i = 1 : N
    freqMean = randi([1 4]);
    W = 0.2*randn(NumMemb(i),1)+freqMean;
    globalW = [globalW; W];
end;

%Starting phases for communities
globalTh = [];
for i = 1 : N
    Th = 2*pi*rand(NumMemb(i), 1);
    globalTh = [globalTh; Th];
end;


%% creating adjecency matrices for each community
%Probability of coupling
Pk = 1;
%Coupling - refelcts the connectivity and the value of coupling at each
%connection
globalAdj = [];
for i = 1 : N
    NumOsc = NumMemb(i);
    CoupDiag = zeros(NumOsc,NumOsc);
    NCoup =round(NumOsc^2*Pk);
    NnonCoup = NumOsc^2 - NCoup;
    %adejcency matrix 1
    K1 = [20*rand(NCoup,1)+20; zeros(NnonCoup,1)];
    % Generate a random index
    idx = randperm(NumOsc^2);
    % Select randomly and reshape
    K1 = reshape(K1(idx),[NumOsc,NumOsc]);
    %make an upper triangualr matrix in order for the resulting matrix to be
    %symmetric
    K1 = triu(K1, 1);
    K1 = K1 + K1';
    globalAdj = blkdiag(globalAdj, K1);
end;
globalAdj
%% adding connections between communities
totalOsc = sum(NumMemb);
totalFilled = nnz(globalAdj)+totalOsc; %all the ones that are filled plus diagonal
%numIterations = (totalOsc^2 - totalFilled)/2;
numIterations = 400;
lastThetas = zeros(totalOsc,numIterations);
%randomly select memembers to be connected
for i=1:numIterations
    osc1 = randi([1 totalOsc]);
    osc2 = randi([1 totalOsc]);
    while globalAdj(osc1, osc2)~=0 || osc1 == osc2
        osc1 = randi([1 totalOsc]);
        osc2 = randi([1 totalOsc]);
    end;
    %pick coupling strength
    Coupling_strength = 20*rand(1,1)+20;
    %connect preserving symmentry
    globalAdj(osc1, osc2) = Coupling_strength;
    globalAdj(osc2, osc1) = Coupling_strength;
    %integrate for span T
    %pedro
    %[time, theta] = kuramoto(globalTh,globalAdj,globalW, [0:0.4:T]);
    dt = T/20;
    [time, theta] = ode45('Theta_rhs_K_inside', [0:dt:T], globalTh, [], globalW, globalAdj, totalOsc);
    theta = theta';
    theta = mod(theta, 2*pi);
    lastThetas(:,i) = theta(:, end);
    %save the last value of theta
    
end;
std_of_thetas = std(lastThetas);
num_connections = [1:numIterations];
plot (num_connections, std_of_thetas);
xlabel('Number of Connections');
time_label = int2str(time(end));
ylabel(['Std at the end of time span',' ',time_label]);
title([int2str(N),' ','communities',' ', mat2str(NumMemb),' ','-members']);
% %% integrating
% [time, theta] = ode45('Theta_rhs_K_inside', [0:0.4:T], globalTh, [], globalW, globalAdj, NumComm*N);
% theta = mod(theta, 2*pi);
% theta = theta';
% olgaPlot(theta(1:N, :), time);
% olgaPlot(theta(N+1:2*N, :), time);
% olgaPlot(theta, time);

% %% pedro test
% [time_pedro,theta_pedro] = kuramoto(Th,K1,W, [0:20:400]);
% theta = mod(theta, 2*pi);
% theta = theta';
% theta_pedro = mod(theta_pedro, 2*pi);
% theta_pedro = theta_pedro
% olgaPlot(theta_pedro, time_pedro)



