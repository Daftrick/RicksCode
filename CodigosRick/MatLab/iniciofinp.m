function palabra = iniciofinp(varargin)
%Funcion Detector Inicio y Fin de Palabra
%La funcion recibe un archivo de audio en la forma '*.wav',
%este archivo debera ser una muestra de voz de una sola palabra,
%la funcion regresara entonces la repoduccion del archivo ingresado
%y cinco graficas donde se muestran: 
%1)El audio original ingresado,
%2)El audio despues de haber aplicado el filtro preenfasis,
%3)El audio despues de haber aplicado el filtro preenfasis y el filtro FIR
%4)El audio en forma de ventanas,
%5)La palabra encontrada en el audio
%El numero de elementos por ventana esta definido en 128

x = audioread(varargin{1});

%Aplicacion de un Filtro FIR a la Señal
xf = ffir(x);

%Aplicacion de un Filtro Preenfasis a la Señal previamente filtrada
xp = preenfasis(xf);

%Ventaneo de la Señal resultante despues de Filtros
[y, ventanas, elementos] = ventaneo(xp, 128);

%Magnitud promedio de la Señal final ventaneada
M = magprom(y, ventanas, elementos);

%Cruces por Cero de la Señal final ventaneada
Z = cruzero(y, ventanas, elementos);

%Coeficientes de la Señal final ventaneada
Mi = M(1: 10);
Zi = Z(1: 10);
Mf = M(length(M) - 9: length(M));
Zf = Z(length(Z) - 9: length(Z));
use = max(M, [], 2)*(0.5);
ucc = mean(Zi, 2) + (std(Zi, 0, 2)*2);
uccf = mean(Zf, 2) + (std(Zf, 0, 2)*2);
uie = mean(Mi, 2) + (std(Mi, 0, 2)*2);
uief = mean(Mf, 2) + (std(Mf, 0, 2)*2);
lei = 0;
lnf = 0;
lef = 0;

if uie < uief
    uie = uief;
end

%%Inicio de la Palabra
for n = 11: 1: length(M)
    if M(n) > use
        lni = n;
        break
    end
end

for i = n: -1: 1 
    if M(i) < uie
        lni = i;
        break
    end
end

for j = lni: -1: 11
    if Z(j) < ucc
        lei = lni;
        break
    end
    if Z(j) > ucc
        if Z(j - 1) > ucc
            if Z(j - 2) > ucc
                lei = j;
                break
            else
            lei = lni;
            end
        end
    end
end

%%Fin de la Palabra
for n = length(M) -10: -1: 1
    if M(n) > use
        lnf = n;
        break
    end
end

for i = n: 1: length(M) - 10
    if M(i) < uie
        lnf = i;
        break
    end
end

for j = lnf: 1: length(M) - 10
    if Z(j) < uccf
        lef = lnf;
    end
    if Z(j) > uccf
        if Z(j + 1) > uccf
            if Z(j + 2) > uccf
                lef = j;
                break
            else
                lef = lnf;
            end
        end
    end
end

%%Recorte de la Palabra
[palabra, longitud] = recortarpalabra(y, lei, lef);

%Grafica de la Señal Original
figure(1); plot(x, 'k'); title('Audio Original');

%Grafica de la Señal despues del Filtro Preenfasis
figure(2); plot(xf, 'r'); title('Filtro FIR');

%Grafica de la Señal con Preenfasis despues del Filtro FIR
figure(3); plot(xp); title('Filtro Preenfasis');

%Audio en Ventanas despues de Filtros
figure(4); plot(y); title('Audio en Ventanas'); xlim([0 ventanas]);

%Palabra Encontrada
figure(5);
plot(palabra); title('Palabra Encontrada'); xlim([0 longitud]);

sound(palabra);

end