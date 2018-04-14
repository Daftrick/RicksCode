function xp = preenfasis(varargin)
%Funcion Filtro Preenfasis
%La funcion preenfasis recibe como parametro de entrada 
%una señal de voz en forma de vector, regresando la señal filtrada
%en forma de vector con las mismas dimensiones queel vector de entrada

x = varargin{1};
xp = zeros(length(x), 1);

%Algoritmo del filtro preenfasis
for n=1: 1: size(x)
    if n - 1 <= 0
        xp(n) = 0;
    else
        xp(n) = x(n) - (0.95*x(n - 1));
    end
end

end