function [palabra, longitud] = recortarpalabra(varargin)
%Funcion Recortar Palabra
%La funcion recibe una señal de voz ventaneada (matriz)
%y dos valores enteros que seran las ventanas en donde se encuentran 
%el inicio y fin de la señal de voz a ser recortada,
%Ejemplo: [palabra, longitud] = recortarpalabra(y, 23, 89); 
%regresando la señal recortada en forma de un vector de 1 renglon y n columnas
%y un numero entero que sera la "longitud" o cantidad de muestras
%de la palabra recortada (columnas) 

yven = varargin{1};
inicio = varargin{2};
final = varargin{3};
t = size(yven);
elementos = t(1, 2);
ventanas = final - inicio;

if ventanas < 0
    inicio = varargin{3};
    final = varargin{2};
    ventanas = final - inicio;
end

longitud = ventanas*elementos;
palabra = zeros(longitud, 1);
n = 1;

while n <= longitud
    for i = inicio: 1: final
        for j = 1: 1: elementos
            palabra(n) = yven(i, j);
            n = n + 1;
        end
    end
end
    
end