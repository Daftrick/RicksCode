function [R1,R2,R3]=PBRAM(varargin)
%La funcion recibe como parametros a H0 que es un entero positivo, a que es
%el factor de amortiguamiento menor a 1, f0 que es una frecuencia en Hertz,
%y C que es el valor del capacitor 1 y 2 menor a 1 [uF].

H=varargin{1};
a=varargin{2};
f=varargin{3};
C=varargin{4};
w=2*pi*f;
Q=1/a;
R1=Q/(H*w*C);
R2=Q/(((2*Q^2)-H)*w*C);
R3=(2*Q)/(w*C);

