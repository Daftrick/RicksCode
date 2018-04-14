function m = magprom(varargin)
%Funcion magnitud de energia promedio
%La funcion recibe una señal de audio en forma de matriz y dos numeros enteros, 
%correspondientes al numero de ventanas (renglones) y elementos (columnas) 
%de la señal de audio en forma de matriz
%Ejemplo: m = magprom(matriz, ventanas, elementos); 
%regresando una matriz de igual magnitud correspondiente a la magnitud de 
%energia promedio de la señal ingresada 

signal = varargin{1};
ventanas = varargin{2};
elementos = varargin{3};
m = zeros(1, ventanas);

for n = 1: 1: ventanas
    for j = 1: 1: elementos
        m(n) = m(n) + abs(signal(n, j));
    end
end

end