function filtroiir1

[x,fs]=audioread('Encendido0.wav');                                            %Leemos un archivo de audio
h=fdesign.bandpass(200,300,3800,3900,10,1,10,fs);           %Disenamos el filtro pasabanda con especificaciones
hd=design(h,'butter','MatchExactly','stopband');                      %Disenamos una funcion de transferencia con el filro
[b,a]=tf(hd);                                                                                           %Obtenemos los coeficientes a y b del filtro                                                                              
N=length(b);                                                                                             
ind=length(b)+1;
ba=zeros(length(x)+ind,1);
aa=zeros(length(x)+ind,1);
y=zeros(length(x)+ind+1,1);
x(size(x)+ind)=0;
yn=filter(b,a,x);

for n=1:1:length(x)+ind
   for i=1:1:N-1
       if n+ind>= size(x)
           break
       else
            ba(n)=ba(n)+(b(i)*x((n+ind)-i));
       end
   end
end

for n=1:1:length(x)+ind
    for i=1:1:N
        if n+ind>= size(x)
           break
       else
        aa(n)=aa(n)+(a(i)*y((n+ind)-(i+1)));
        i=i-1;
        end
    end
end

for n=1:1:length(x)+ind
    if n>=size(x)
        break
    else
    y(n)=ba(n)-aa(n);
    end
end
figure(1);
subplot(2,1,1);
plot(y);
subplot(2,1,2);
plot(yn);
pause;
close all
end