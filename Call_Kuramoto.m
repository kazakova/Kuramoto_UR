%% Call Kuramoto

clear all
close all
clc

%% Description
%
% In this code, we ...
% 
% $$e^{\pi i} + 1 = 0$$
% 

numOsc = 5;
%initial theta
ic = 0*[1;2;3;4;5];
%adj = 10*rand(5,5);
%adj = eye(5);

% from the example 
adj = [1,0,0,0,0;...
       1,1,0,0,0;...
       1,0,1,0,0;...
       1,0,0,1,1;...
       0,0,0,1,1];
adj = adj.*5;
figure
cm = flipud(bone);
colormap(cm)
imagesc(adj-eye(5),[0,1])   
   
w = 0.5*[1;1;5;5;1];
tSpan = [0,30];

[T,Y] = kuramoto(ic,adj,w,tSpan);

n = size(T, 2);
figure
for j = 1:numOsc
oscilator{j} = cos(Y(:,j))+ 20*(rand(n,1)-.5);
    
subplot(numOsc,1,j)
%plot(T,mod(Y(:,j),2*pi))
%plot(T,real(exp(1i*Y(:,j))))
plot(T,oscilator{j})
end