function alpha = LPCs(varargin)

rs = autocorrelacion(varargin{1}, 9);
[rows, columns] = size(rs);
alpha = zeros(columns - 1, rows);

for l = 1: rows
    r = rs(l, :);
    E = zeros(1, columns);
    K = zeros(1, columns - 1);
    a = zeros(columns - 1); 
    E(1, 1) = r(1, 1);

    for i = 1: columns - 1
        temporal = 0;
        for j = 1: i - 1 
            temporal = temporal + a(j, i - 1)*r(abs(i + 1 - j));
        end
        K(i) = (r(1, i + 1) - temporal)/E(i);
        a(i, i) = K(i);
        for j = 1: i - 1
            a(j, i) = a(j, i - 1) - K(i)*a(i - j, i - 1);
        end
        E(i + 1) = (1 - K(i)^2)*E(i);
    end
    alpha(:, l) = a(:, columns - 1);
    b0 (:, l) = sqrt(E(i)); 
end

end
