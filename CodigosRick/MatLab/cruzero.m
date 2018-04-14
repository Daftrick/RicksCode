function z = cruzero(varargin)
%Funcion Cuces por Cero
%La funcion recibe una señal de audio en forma de matriz y dos numeros enteros, 
%correspondientes al numero de ventanas (renglones) y elementos (columnas) 
%de la señal de audio en forma de matriz
%Ejemplo: z = cruzero(matriz, ventanas, elementos); 
%regresando una matriz de igual magnitud correspondiente al numero de 
%veces promedio que cruza la señal por 0 durante cada ventana

signal = varargin{1};
ventanas = varargin{2};
elementos = varargin{3};
z = zeros(1, ventanas);                 
n = 1;

while n <= ventanas - 1
    for j = 1: 1: elementos
        if j == elementos
            z(n) = z(n)/(2*elementos);
            n = n + 1;
        else
            z(n) = z(n) + abs(sign(signal(n , j + 1)) - sign(signal(n, j)));
       end
   end
 end
       
end
 