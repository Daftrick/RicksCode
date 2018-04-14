function xffir = ffir(varargin)
%Funcion Filtro FIR
%La funcion FIR recibe como parametro de entrada 
%una señal de voz en forma de vector, regresando una señal filtrada
%en forma de vector con las mismas dimensiones del vector de entrada
%Estan definidos 100 coeficientes del filtro con una fn de 4000
%Fn esta calculada para señales de 16000 elementos

x = varargin{1};
xffir = zeros(length(x),1);
fn = 4000;
n = 100;

%Calculo de los coeficientes del filtro
b = fir1(n,[300 3800]/fn,'bandpass');
M = length(b);

%Algoritmo del filtro FIR
for i = 1: 1: length(x)
    for k=1: 1: M
        if (i - k <= 0)
        xffir(i) = xffir(i);
        else
        xffir(i)= xffir(i) + (b(k)*(x(i - k)));
        end
    end
end

end
