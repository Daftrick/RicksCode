function [R1,R2,Rc,Re,Rb,Bd,Zi,Zo,Aicc,Avsc,Avcc] = darlington(Vcc,Vceq,Icq,B1,B2)
Vbe=1.5;
Bd=B1*B2;
Rc = Vceq/Icq;
Re = 0.1*Rc;
Rb = 0.1*Bd*Re;
Vbb = (((Rb/Bd) + Re)*Icq) + Vbe;
R1 = (Vcc*Rb)/Vbb;
R2 = (Vcc*Rb)/(Vcc-Vbb);
Ve=Vbb-Vbe;
Ie2 = Ve/Re;
re2 = 0.026/Ie2;
Ie1 = Ie2/B2;
re1 = 0.026/Ie1;
RL=Rc;
RL1 = RL/2;
Zi1 = (B1*(re1+(B2*re2)));
Zi = 1/((1/R1)+(1/R2)+(1/(Zi1)));
Aicc = (Bd*((R1*R2)/(R1+R2)))/(((R1*R2)/(R1+R2))+Zi1);
Avsc = (Bd*Rc)/Zi1;
Avcc = (Bd*RL1)/Zi1;
Zo = RL1; 
end 