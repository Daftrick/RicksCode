#include "preenfasis.h" //cabecera donde esta la definicion de la funcion

short v[2]={0,0}; //vector de dos valores
short ent; //variable de entrada

//declaracion de la funcion preenfasis
short preenfasis(short ent){
	long tem = 0; //inicializa temporal
	tem = (31130*v[0]);//Q15*0.95=31130
	v[1] = ent-((tem)>>15); //recorremos el temporal a Q15
	v[0] = ent;
	return v[1];
}


