function archivofiltrofir

[x,fs]=audioread('Avanzar0.wav');
sound(x);
fn=fs/2;
n=100;
b=fir1(n,[300 3800]/fn,'bandpass');
[pmax,pmin,nmax,nmin] = maxmin(b);
Q = Qdet(pmax,pmin,nmax,nmin);
fprintf('Debes usar una Q de: %i\n',Q);
L=length(b);
for i=1:L
    b(1,i)=b(1,i)*2^Q;
end
fid=fopen('indices.h','w');
fprintf(fid,'short b[%i]={%i,',L,b(1,2));
for i=3:1:L
    fprintf(fid,' %i,',b(1,i));
    if (i == L)
        fprintf(fid,' %i };',b(i));
    end
end