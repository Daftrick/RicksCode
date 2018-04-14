function [R,K,Q]=PBFVCV(varargin)
%La funcion recibe como parametros a H0 que es un entero positivo, a que es
%el factor de amortiguamiento menor a 1, f0 que es una frecuencia en Hertz,
%y C que es el valor del capacitor 1 y 2 menor a 1 [uF].

H=varargin{1};
f=varargin{2};
C=varargin{3};
w=2*pi*f;
R=(sqrt(2))/(w*C);
Q=(((sqrt(2))/5)*H)+1;
K=5-((sqrt(2))/Q);