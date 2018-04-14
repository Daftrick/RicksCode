function Q=Qdet(varargin)
pmax=varargin{1};
pmin=varargin{2};
nmax=varargin{3};
nmin=varargin{4};
Qpmax=0;
Qpmin=0;
Qnmax=0;
Qnmin=0;
i=15;
while i >= 0
    if pmin <= 2^-i
        Qpmax=i;
        break;
    else
        i=i-1;
    end
end
i=15;
while i >= 0
    if nmin >= -2^-i
        Qnmax=i;
        break;
    else
        i=i-1;
    end
end
j=0;
while j <= 15
    if 2^j < pmax
       j=j+1;
    else
        Qpmin=j;
        break;
    end
end
j=0;
while j <= 15
    if -2^j > nmax
       j=j+1;
    else
        Qnmin=j;
        break;
    end
end
Qp=Qpmax-Qpmin;
Qn=Qnmax-Qnmin;
if Qp>Qn
    Q=Qp;
else
    Q=Qn;
end