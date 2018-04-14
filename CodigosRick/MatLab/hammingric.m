function y = hammingric(varargin)

x = varargin{1};
v = varargin{2};
e = varargin{3};
h = hamming(e);
y = zeros(v, e);

for i = 1: 1: v
    for j = 1: 1: e
        y(i, j) = x(i, j)*h(j);
    end
end

end