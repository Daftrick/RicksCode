#include <dsk6713.h>
#include <dsk6713_aic23.h>
#include <dsk6713_dip.h>
#include <dsk6713_led.h>

/*Uint32 fs=DSK6713_AIC23_FREQ_8KHZ; //frecuencia de muestreo
#include "voz.h" //libreria archivo de audio
#include "preenfasis.h" //libreria funcion preenfasis
#include "indices.h" //libreria de indices del filtro fir
 

short y[3]={11585,-16384,11585}; //coeficientes senoide: 0.7071,-1,0.7071 (f=6000 Hz: fs 16000 Hz)
short ent1, ent2;
short ff[2] = {0,0};
int i = 0; //indice i para recorrer archivo de voz
int j, k;

void c6713_dsk_init();
void comm_poll();
void comm_intr();
void output_sample(int);
Uint32 input_sample();

short preenfasis(short); //definicion de la funcion preenfasis
short filtrofir(short, short, int); //definicion de la funcion filtrofir
void senoide(); //definicion de la funcion

interrupt void c_int11() //rutina de interrupcion
{
	//voz en tiempo real: switch 0
	if (DSK6713_DIP_get(0) == 0 && DSK6713_DIP_get(1) == 1 && DSK6713_DIP_get(2) == 1 && DSK6713_DIP_get(3) == 1) {
		output_sample((short)input_sample());}//salida de los datos

	//senoidal: switch 1
	else if (DSK6713_DIP_get(0) == 1 && DSK6713_DIP_get(1) == 0 && DSK6713_DIP_get(2) == 1 && DSK6713_DIP_get(3) == 1) {
		senoide();
		output_sample(y[0]);}//salida de los datos

	//senoidal + voz en tiempo real: switch 2
	else if (DSK6713_DIP_get(0) == 1 && DSK6713_DIP_get(1) == 1 && DSK6713_DIP_get(2) == 0 && DSK6713_DIP_get(3) == 1) {
		senoide();
		output_sample((y[0]>>1) + (short)input_sample());}//salida de los datos

	//senoidal + archivo de voz: switch 3
	else if (DSK6713_DIP_get(0) == 1 && DSK6713_DIP_get(1) == 1 && DSK6713_DIP_get(2) == 1 && DSK6713_DIP_get(3) == 0) {
		senoide();
		output_sample((y[0]>>1) + preenfasis((vox[i])));}//salida de los datos;
		
	//archivo de voz: switches desactivados
	//filtro fir y filtro preenfasis
	else {
		ent1 = preenfasis(vox[i]);
		ff[0] = ent1; 
		for (j=0; j<=101; j++){
			k = i-j;
			if (k <= 0){
				ff[0] = ff[0];
			}
			else {				
				ent2 = preenfasis(vox[k]);
				long tempo = 0;
				tempo = b[j] * ent2;
				ff[1] = ff[0] + ((tempo)>>15);
				ff[0] = ff[1];
			}
		}
		output_sample(ff[1]);//salida de los datos
	}

	i++; //incrementa el indice del archivo de voz
	if (i==16000) i = 0; //Reinicia el indice
	return;
}
*/
void main()
{
	c6713_dsk_init(); //iniciamos DSK
	DSK6713_LED_init();// iniciamos LEDs
	comm_poll(); //codec, McBSP
	comm_intr();//inicia las interrupciones

	//se crea el un bucle infinito
	while(1){
		//encendemos led 0 con swtch 0
		if (DSK6713_DIP_get(0) == 0)
		{
			DSK6713_LED_on(0);
		}
		else {
			DSK6713_LED_off(0);
		}
		//encendemos led 1 con swtch 1
		if (DSK6713_DIP_get(1) == 0)
		{
			DSK6713_LED_on(1);
		}
		else {
			DSK6713_LED_off(1);
		}
		//encendemos led 2 con swtch 2
		if (DSK6713_DIP_get(2) == 0)
		{
			DSK6713_LED_on(2);
		}
		else {
			DSK6713_LED_off(2);
		}
		//encendemos led 3 con swtch 3
		if (DSK6713_DIP_get(3) == 0)
		{
			DSK6713_LED_on(3);
		}
		else {
			DSK6713_LED_off(3);
		}
	}
}
/*
void senoide()//Q15
{
	const short a1= -23170; //-0.7071*2^15
	int temp=0;
	temp = a1 * y[2];
	y[0]= ((temp)>>15) - ( y[1]);
	y[1]= y[2];
	y[2]= y[0];
}
*/
