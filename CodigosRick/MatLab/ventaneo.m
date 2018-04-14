function [y, ventanas, elementos] = ventaneo(varargin)
%Funcion ventaneo 
%La funcion recibe un archivo de audio en forma de vector y un numero entero
%Ejemplo: [y,ventanas,elementos] = ventaneo(vector, 128);
%regresando una matriz con un numero de ventanas (renglones) acorde a la duracion del archivo
%ingresado y con un numero de elementos (columnas) por ventana igual al numero entero ingresado
%y dos numeros enteros, correspondientes al numero de ventanas y elementos de esa matriz respectivamente 

x = varargin{1};
elementos = varargin{2}; 
t = length(x);

res = rem(t, (elementos));
if res(1, 1) > 0
ven = floor(t/(elementos)) + 1;
else
    ven = floor(t/(elementos));
end
ventanas = ven(1, 1);
y = zeros(ventanas, elementos);

i = 1;
while i <= t
    for j = 1: 1: ventanas
        for k = 1: 1: elementos
            y(j, k) = x(i);
            i = i + 1;
        end
    end
end

end