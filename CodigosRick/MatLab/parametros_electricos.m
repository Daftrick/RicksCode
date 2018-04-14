%parametros_electricos
Zo=50;
f=5e9;
R=195;
C=0.3e-12;
c=2*pi*f*1i*C;
r=100;
Nfq= 0.54;
Goptq=0.45*exp(1j*174*pi/180);
Rnq= 1.5;
K=1.38e-23;
T=290;


s11q=0.64*exp(1j*139*pi/180);
s12q=0.119*exp(-1j*21*pi/180);
s21q=03.165*exp(1j*16*pi/180);
s22q=0.22*exp(1j*146*pi/180);
sq=[s11q s12q; s21q s22q];

%estabilidad y estabilizacion
Dsq= abs(s11q*s22q-s12q*s21q);
Ksq=(1+(abs(Dsq))^2-(abs(s11q))^2-(abs(s22q))^2)/(2*abs(s12q*s21q));


den=((1-s11q)*(1-s22q))-s12q*s21q;
z11q= Zo*(((1+s11q)*(1-s22q)+s12q*s21q)/den);
z12q= Zo*((2*s12q)/den);
z21q= Zo*((2*s21q)/den);
z22q= Zo*(((1-s11q)*(1+s22q)+s12q*s21q)/den);
zq=[z11q z12q; z21q z22q];


zr=[R R; R R];

zqr=zq+zr;

zqr11=zqr(1,1);
zqr12=zqr(1,2);
zqr21=zqr(2,1);
zqr22=zqr(2,2);

azqr=zqr11*zqr22-zqr12*zqr21;

yqr11=zqr22/azqr;
yqr12=-zqr12/azqr;
yqr21=-zqr21/azqr;
yqr22=zqr11/azqr;
yqr=[yqr11 yqr12; yqr21 yqr22];

yc= [c -c; -c c];

yqrc= yqr +yc;
yqrc11=yqrc(1,1);
yqrc12=yqrc(1,2);
yqrc21=yqrc(2,1);
yqrc22=yqrc(2,2);


Yo=1/Zo;

dY=(yqrc11+Yo)*(yqrc22+Yo)-yqrc12*yqrc21;

sqrc11=(((Yo-yqrc11)*(Yo+yqrc22)+yqrc12*yqrc21)/dY); 
sqrc12=((-2*yqrc12*Yo)/dY);  
sqrc21=((-2*yqrc21*Yo)/dY);
sqrc22=(((Yo+yqrc11)*(Yo-yqrc22)+yqrc12*yqrc21)/dY);
sqrc=[sqrc11 sqrc12; sqrc21 sqrc22];

%estabilidad
Dsqrc= abs(sqrc11*sqrc22-sqrc12*sqrc21);
Ksqrc=(1+(abs(Dsqrc))^2-(abs(sqrc11))^2-(abs(sqrc22))^2)/(2*abs(sqrc12*sqrc21));

rsqrc11=abs(sqrc11);
rsqrc12=abs(sqrc12);
rsqrc21=abs(sqrc21);
rsqrc22=abs(sqrc22);
asqrc11=angle(sqrc11)*180/pi;
asqrc12=angle(sqrc12)*180/pi;
asqrc21=angle(sqrc21)*180/pi;
asqrc22=angle(sqrc22)*180/pi;

rsqrc=[rsqrc11 rsqrc12; rsqrc21 rsqrc22];
asqrc=[asqrc11 asqrc12; asqrc21 asqrc22];

ABCDsqrc=s2abcd(sqrc);

%conexion cascada
ABCDr=[1 r; 0 1];
ABCDr11= ABCDr(1,1);
ABCDr12= ABCDr(1,2);
ABCDr21= ABCDr(2,1);
ABCDr22= ABCDr(2,2);

Aqrcr=ABCDsqrc*ABCDr;

Sqrcr=abcd2s(Aqrcr);
Sqrcr11=Sqrcr(1,1);
Sqrcr12=Sqrcr(1,2);
Sqrcr21=Sqrcr(2,1);
Sqrcr22=Sqrcr(2,2);

%estabilidad
Dsqrcr= abs(Sqrcr11*Sqrcr22-Sqrcr12*Sqrcr21);
deltasqrcr=Sqrcr11*Sqrcr22-Sqrcr12*Sqrcr21;
Ksqrcr=(1+(abs(Dsqrcr))^2-(abs(Sqrcr11))^2-(abs(Sqrcr22))^2)/(2*abs(Sqrcr12*Sqrcr21));

%parámetros de ruido

Czr=2*K*T*real(zr);

Zopt=-((Zo*Goptq+Zo)/(Goptq-1));
Yopt=Zopt^-1;

Fmin=10^((Nfq)/10);

Caq=2*K*T*[Rnq ((Fmin-1)/2)-(Rnq*conj(Yopt)); ((Fmin-1)/2)-(Rnq*Yopt) Rnq*(abs(Yopt))^2];

Caq11=Caq(1,1);
Caq12=Caq(1,2);
Caq21=Caq(2,1);
Caq22=Caq(2,2);

Cazq=[1 -z11q; 0 -z21q];
Czq=Cazq*Caq*Cazq';

Czqr= Czq+Czr;

Cyqr=yqr*Czqr*yqr';

Cyc= 2*pi*K*real(yc);

Cyqrc=Cyqr+Cyc;
Cyqrc11=Cyqrc(1,1);
Cyqrc12=Cyqrc(1,2);
Cyqrc21=Cyqrc(2,1);
Cyqrc22=Cyqrc(2,2);
Cyqrc=[Cyqrc11 Cyqrc12; Cyqrc21 Cyqrc22];


Aqrc=s2abcd (sqrc,Zo);

Aqrc11=Aqrc(1,1);
Aqrc12=Aqrc(1,2);
Aqrc21=Aqrc(2,1);
Aqrc22=Aqrc(2,2);

Cbqrc=[0 Aqrc12; 1 Aqrc22];

Caqrc=Cbqrc*Cyqrc*Cbqrc';

Caqrc11=Caqrc(1,1);
Caqrc12=Caqrc(1,2);
Caqrc21=Caqrc(2,1);
Caqrc22=Caqrc(2,2);

Yoptqrc= sqrt((Caqrc22/Caqrc11)-(imag(Caqrc12/Caqrc11))^2)+1i*imag(Caqrc12/Caqrc11);
Zoptqrc=Yoptqrc^-1;

Goptqrc=[abs((Zoptqrc-Zo)/(Zoptqrc+Zo)),angle(Zoptqrc-Zo/Zoptqrc+Zo)*180/pi];

Fminqrc= abs(1+(Caqrc12+Caqrc11*conj(Yoptqrc))/(K*T));

Rnqrc=abs(Caqrc11/(2*K*T));

Nfqrc=10*log10(Fminqrc);

%%maxima ganancia 
B1=(1+(abs(Sqrcr11)^2)-(abs(Sqrcr22)^2)-Dsqrcr^2);
B2=(1+(abs(Sqrcr22)^2)-(abs(Sqrcr11)^2)-Dsqrcr^2);
C1=Sqrcr11-deltasqrcr*conj(Sqrcr22);
C2=Sqrcr22-deltasqrcr*conj(Sqrcr11);

GamaG1=(B1+sqrt(B1^2-(4*(abs(C1)^2))))/(2*C1);
GamaG2=(B1-sqrt(B1^2-(4*(abs(C1)^2))))/(2*C1);
GamaC1=(B2+sqrt(B2^2-(4*(abs(C2)^2))))/(2*C2);
GamaC2=(B2-sqrt(B2^2-(4*(abs(C2)^2))))/(2*C2);

GG2=[abs(GamaG2), angle(GamaG2)*180/pi];
GC2=[abs(GamaC2), angle(GamaC2)*180/pi];

%Obtener redes de acoplamiento con carta de Smith
%con eso obtenemos la admitancia o suceptancia del stub
%y las longitudes de las linea de transmision
%obtener ganancia total y Zsal y Zent, estas ultimas deben de ser iguales
%repasar parametros abcd de lineas de transmision y checar abcd de los stub
%no olvidar el orden en que se multiplican las matrices abcd para el
%amplificador final
%Repasar del possart que es el libro de cabecera, ahi revisar carta de
%smith y ejercicio de redes de acoplamiento
%estabilizar y dar maxima ganancia 
%estabilizar y dar bajo ruido
%libro gonzalez para estabilidad
%Para bajo ruido es necesario hacer lo siguiente
%obtener Gamma G utilizando gamma optima y las redes de acoplamiento
%obtenido lo anterior igular gamma de salida de la red activa + red de acoplamiento 
%de la entrada con el complejo conjugado de de la gamma de la red de acoplamiento de la salida
%linea y stub con Zsal con parametros ABCD de las notas