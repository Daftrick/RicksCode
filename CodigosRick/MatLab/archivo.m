function archivo
x=audioread('Avanzar0.wav');
[pmax,pmin,nmax,nmin] = maxmin(x);
Q = Qdet(pmax,pmin,nmax,nmin);
fprintf('Debes usar una Q de: %i\n',Q);
L=length(x);
for i=1:L
    x(i,1)=x(i,1)*2^Q;
end
fid=fopen('voz.h','w');
fprintf(fid,'short vox[%i]={%i,',L,x(2,1));
for i=3:1:L
    fprintf(fid,' %i,',x(i,1));
    if (i == L)
        fprintf(fid,' %i };',x(i));
    end
end