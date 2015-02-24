function rhs = Theta_rhs_K_outside(T, Th, dummy, W, K, N)
K = 20*ones(N, 1);
ThMatrix = Th * ones(1, N);
DiffMatrix = ThMatrix'-ThMatrix;
SinOfDiff = sin(DiffMatrix);
SumOfSin = sum(SinOfDiff, 2);
rhs = W + (SumOfSin.*K)/N;
end

