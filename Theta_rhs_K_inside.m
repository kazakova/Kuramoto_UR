function rhs = Theta_rhs_K_inside(T, Th, dummy, W, K, N)
ThMatrix = Th * ones(1, N);
DiffMatrix = ThMatrix'-ThMatrix;
SinOfDiff = sin(DiffMatrix);
SinOfDiff = SinOfDiff.*K;
SumOfSin = sum(SinOfDiff, 2);
rhs = W + SumOfSin/N;
end

