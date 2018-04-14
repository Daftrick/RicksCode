function [R1,R2,Rc,Re,Rb,Cpi,Cu,C1,C2,Ce,fH] = tbjpol(Vcc,Vceq,Icq,wt,wo,wL,Cu,Ri)
B=wt/wo;
Vbe = 0.65;
Rc = Vceq/(Icq);
Re = 0.1*Rc;
Rb = 0.1*(B+1)*Re;
Vbb = (((Rb/B) + Re)*Icq) + Vbe;
R1 = (Vcc*Rb)/Vbb;
R2 = (Vcc*Rb)/(Vcc-Vbb);

RL = Rc;
Vt=0.026;
gm = Icq/Vt;
rpi = B/gm;
Rq = (Rc*RL)/(Rc+RL);
Cpi = (gm/(2*pi*wt)) - Cu;
Rcc1 = Ri+(1/((1/R1)+(1/R2)+(1/rpi)));
Rcc2 = RL + Rc;
Rce = 1/((1/Re)+((rpi+(1/((1/Ri)+(1/R1)+(1/R2))))/(B+1)));

Ce = 1/(wL*Rce);
C1 = 10/(wL*Rcc1);
C2 = 20/(wL*Rcc2);

Rcpi = 1/((1/rpi)+(1/(Rb+(1/((1/Ri)+(1/R1)+(1/R2))))));
Rcu = 1/((1/Rc)+(1/(RL+(Rcpi*(1+(gm*Rq))))));
fH = 1/(2*pi*((Cu*Rcu)+(Cpi*Rcpi)));

end 
