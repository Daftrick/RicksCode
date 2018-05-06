function [x,C1,C2,L,Re,Qt,fo,n,gmq,Ieq,RL,Vcc,GT]=oscilador(x,Vo,fo,THD,B,RL,Vee)
wo = fo*2*pi;
if x == 2
    D = 0.294;
    Gg = 0.6073;
end
if x == 5
    D = 0.5;
    Gg = 0.36;
end
if x == 10
    D = 0.642;
    Gg = 0.19;
end
if x == 20
    D = 0.727;
    Gg = 0.1;
end
Qt = D/THD;
C = Qt/(RL*wo);
L = 1/(wo^2*C);
Vt = 0.026;
n = (x*Vt)/Vo;
C1 = C/(1-n);
C2 = (C1-n*C1)/n;
GL = 1/RL;
a = B/(B+1);
Gm = GL/n;
gmq = Gm/Gg;
Ieq = Vt*gmq;
Re = (Vee-0.7)/Ieq;
GE = 1/Re;
gin = gmq/a;
GT = GL+(n^2*(GE + (gin/a)));
Vcc = Vee;
end