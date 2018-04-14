function autoco = autocorrelacion(varargin)
%Funcion autocorrelacion
%La funcion autocorrelacion recibe un archivo de voz '*.wav', 
%y un numero entero "p" (orden de los coeficientes LPC), 
%regresando una matriz de autocorrelacion (ventanas, p) donde el numero de ventanas 
%sera definido a partir de segmentar la señal de voz en trazas de 128 elementos

%Obtencion de la palabra contenida en el archivo
palabra = iniciofinp(varargin{1});
p = varargin{2};

%Segmentacion de la palabra encontrada en ventanas de 128 elementos
[y, ventanas, elementos] = ventaneo(palabra, 128);

%Algoritmo Ventana de Hamming
h = hamming(elementos);
yven = zeros(ventanas, elementos);

for i = 1: 1: ventanas
    for j = 1: 1: elementos
        yven(i, j) = y(i, j)*h(j);
    end
end

%Algoritmo Autocorrelacion
autoco = zeros(ventanas, p);

for i = 1: 1: ventanas
    for k = 1: 1: p
        for j = 1: 1: elementos - 1 - k
            autoco(i, k) = yven(i, j)*yven(i, j + k);
        end
    end
end

end