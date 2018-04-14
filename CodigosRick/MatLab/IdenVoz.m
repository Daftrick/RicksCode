function IdenVoz(varargin)
%Funcion para la identificacion del inicio y fin de una muestra de voz.
%La funcion graba una senal de voz, la cual es graficada y posteriormente
%se identifican los cruces por cero asi como los umbrales superiores de
%energia, con los cuales se hace la identificacion, gracias al algoritmos
%de Rabiner-Sambur.
%La funcion recibe un archivo de voz '*.wav' el cual sera analizado.
 
x=audioread(varargin{1});
figure(1);
subplot(3,1,1);
plot(x);                   %Graficamos el archivo de voz
pause;
[y,ventanas,elementos]=ventaneo(varargin{1},128);
M=magprom(y,ventanas,elementos);
plot(y);
[lei,lef]=iniciofinp(M,y);
pause;

palabra=recortarpalabra(y,lei,lef);
figure(2); plot(palabra);
subplot (3,1,1);
plot (elementos);
pause;
subplot(3,1,2);
plot(M);
pause;
Z=cruzero(y,ventanas,elementos);
plot(Z);
subplot(3,1,3);

