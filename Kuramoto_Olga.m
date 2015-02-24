
close all; clear all; clc;
%% algorythm
%number of oscilators in each community
N = 30;
NumComm = 2;
totalN = NumComm*N;

%number communities and number of oscilators in them
% minmemb = 30;
% maxmemb = 60;
% N = 2;
% NumMemb = zeros(1, N);
% for i = 1 : N
%     NumMemb = randi([minmemb maxmemb]);
% end;
%time span
T = 5;
%natural frequency for 3 communities
W1 = 0.2*randn(N,1)+1;
W2 = 0.2*randn(N,1)+2;
%thetas for three communities
Th1 = 2*pi*rand(N, 1);
Th2 = 2*pi*rand(N, 1);

%% creating adjecency matrices for each community
%Probability of coupling
Pk = 1;
%Coupling - refelcts the connectivity and the value of coupling at each
%connection
CoupDiag = zeros(N,N);
NCoup =round(N^2*Pk);
NnonCoup = N^2 - NCoup;

%adejcency matrix 1
K1 = [20*rand(NCoup,1)+20; zeros(NnonCoup,1)];
% Generate a random index
idx = randperm(N^2);
% Select randomly and reshape
K1 = reshape(K1(idx),[N,N]);
%make an upper triangualr matrix in order for the resulting matrix to be
%symmetric
K1 = triu(K1, 1);
K1 = K1 + K1';

%adjecency matrix 2
K2 = [10*rand(NCoup,1)+20; zeros(NnonCoup,1)];
% Generate a random index
idx = randperm(N^2);
% Select randomly and reshape
K2 = reshape(K2(idx),[N,N]);
%make an upper triangualr matrix in order for the resulting matrix to be
%symmetric
K2 = triu(K2, 1);
K2 = K2 + K2';

%% put communities together
globalAdj = blkdiag(K1, K2);
globalW = [W1; W2];
globalTh = [Th1; Th2];

%% adding connections between communities
numIterations = (N*N)/2;
lastThetas = zeros(totalN,numIterations);
%randomly select memembers to be connected
for i=1:numIterations
    osc1 = randi([1 N]);
    osc2 = randi([N+1 2*N]);
    while globalAdj(osc1, osc2)~=0
        osc1 = randi([1 N]);
        osc2 = randi([N+1 2*N]);
    end;
    %pick coupling strength
    Coupling_strength = 20*rand(1,1)+20;
    %connect preserving symmentry
    globalAdj(osc1, osc2) = Coupling_strength;
    globalAdj(osc2, osc1) = Coupling_strength;
    %integrate for span T
    [time, theta] = ode45('Theta_rhs_K_inside', [0:0.4:T], globalTh, [], globalW, globalAdj, NumComm*N);
    theta = theta';
    theta = mod(theta, 2*pi);
    lastThetas(:,i) = theta(:, end);
    %save the last value of theta
    
end;
std_of_thetas = std(lastThetas);
num_connections = [1:numIterations];
plot (num_connections, std_of_thetas);

%% integrating
% [time, theta] = ode45('Theta_rhs_K_inside', [0:0.4:T], globalTh, [], globalW, globalAdj, NumComm*N);
% theta = mod(theta, 2*pi);
% theta = theta';
% olgaPlot(theta(1:N, :), time);
%olgaPlot(theta(N+1:2*N, :), time);
%olgaPlot(theta, time);

%% pedro test
% [time_pedro,theta_pedro] = kuramoto(Th,K1,W, [0:20:400]);
% theta = mod(theta, 2*pi);
% theta = theta';
% theta_pedro = mod(theta_pedro, 2*pi);
% theta_pedro = theta_pedro
% olgaPlot(theta_pedro, time_pedro)


