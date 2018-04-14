function [Rc1,Re,R1,R2,Rb1,Rb2,Rc2,Avsc,Avcc,Aicc,Zi,Zo,Ce1,Cb2,C1,C2,fo,fH1,fH2,Cpi1,Cpi2,Cu1,Cu2] = cascodo2(Vcc,Ict,Icq2,Vceq,Vcq,B,Vbe1,Vbe2,Ri,fo,fL,Cu1,Cu2)
Rc1 = (Vcc-Vcq)/Ict;
Icq1 = Ict-Icq2;
Re = (Vcq-Vceq)/Icq1;
Vbb1 = Vbe1 + (Re*Icq1);
Rb1= 0.1*(B+1)*Re;

R1 = (Rb1*Vcc)/Vbb1;
R2 = (Rb1*Vcc)/(Vcc-Vbb1);
Rb2 = ((Vcq-Vbe2)/Icq2)*B;
Rc2 = (Vcq-Vceq)/Icq2;

RL = Rc2;
Vt=0.026;
gm1 = Icq1/Vt;
gm2 = Icq2/Vt;
rpi1=B/gm1;
rpie=B/gm2;
Ri1 = (Rb1*Ri)/(Rb1+Ri);
Rq = (Rc2*RL)/(Rc2+RL);

Avsc = (Rc2*gm2)*-((Rc1*rpie*gm1)/(Rc1+rpie))*((Rb1*rpi1)/((Rb1+Ri)*(Ri1+rpi1)));
Avcc = (Rq*gm2)*-((Rc1*rpie*gm1)/(Rc1+rpie))*((Rb1*rpi1)/((Rb1+Ri)*(Ri1+rpi1)));
Aicc = ((Rc2*gm2)/(Rc2+RL))*-((Rc1*rpie*gm1)/(rpie+Rc1))*((Rb1*rpi1)/(Rb1+rpi1));
Zi = (Rb1*rpi1)/(Rb1+rpi1);
Zo = Rc2;

Rcpi1 = (1/((1/Ri)+(1/R1)+(1/R2)+(1/rpi1)));
Rcu1 = (1/gm2)+(2*(1/((1/Ri)+(1/R1)+(1/R2)+(1/rpi1))));
Rcpi2 = 1/gm2;
Rcu2 = Rq;

Rcc1 = Ri+(1/((1/R1)+(1/R2)+(1/rpi1)));
Rcc2 = Rc2+RL;
Rcb2 = 1/((1/Rb2)+(1/(rpie+((B+1)*Rc1))));
Rce1 = 1/((1/Re)+(1/((rpi1+Ri1)/(B+1))));
 
Ce1 = 1/(fL*Rce1*2*pi);
Cb2 = 1/(fL*Rcb2*2*pi);
C1 = 10/(fL*Rcc1*2*pi);
C2 = 20/(fL*Rcc2*2*pi);

Cpi1 = gm1/300e+6 - Cu1;
Cpi2 = gm2/300e+6 - Cu2;

fH1 = 1/(2*pi*((Cpi1*Rcpi1)+(Cu1*Rcu1)));
fH2 = 1/(2*pi*((Cpi2*Rcpi2)+(Cu2*Rcu2)));
end