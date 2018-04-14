function [pmax,pmin,nmax,nmin] = maxmin(varargin)
x=varargin{1};
pmax=0;
pmin=0;
nmax=0;
nmin=0;
for i=1:1:length(x)
    for j=2:1:length(x)
        if x(j) < x(i)
            pmin = x(j);
        end
    end
end
for i=1:1:length(x)
    if pmax < x(i)
        pmax = x(i);
    end    
end
for i=1:1:length(x)
    if nmax > x(i)
        nmax = x(i);
    end    
end
for i=1:1:length(x)
    if x(i) < 0 && x(i) > nmax
            nmin = x(i);
    end
end