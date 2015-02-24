function dThetas = kuramotoFormula(t, thetas, K, w)
dThetas = zeros(size(thetas, 1), 1);
for i = 1 : size(thetas, 1)
    sum = 0;
    for j = 1 : size(thetas, 1)
        sum = sum + sin(thetas(j) -  thetas(i));
    end;
    dThetas(i) = w(i)+K/size(thetas, 1)*(sum);
end;
end

