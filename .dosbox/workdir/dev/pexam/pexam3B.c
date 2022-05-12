// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// +++++++++++   Practica 3 - SBM 2022 - Examen
// +++++++++++   v: ddga
// Nombre Alumno:
// Modelo: B - HARRY POTTER
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include <stdio.h>
#include <stdlib.h>


//declaración funciones (no usando .h)
unsigned int rutaQuid(unsigned long* acelera_x, unsigned long* acelera_y, unsigned long* acelera_z,  
					char modeloNimbus, int numJugadores, int numAtacantes, int numDefensores,
					int conjuroPermitido, int magiaNegra, int* vel_x, int* vel_y, int* vel_z, 
					unsigned int AscendioCon);


void Decode(char* encriptado, char* desencrip,
			int rotM);

// INICIO CODIGO C
int main(){
	//variables para Ejercicio 1
	unsigned long acel_x, acel_y, acel_z;
	int vel_x, vel_y, vel_z;
	char modeloNimbus = 2; //2k id = nimbus2000
	unsigned int AscendioHarry = 80;
	int numJugadores = 14;
	int numAtacantes = 8;
	int numDefensores = 3;
	int conjuroPermitido = 35;
	int magiaNegra = 36;
	unsigned int usoAscendio = 0;


	//variables para Ejercicio 2
	char encriptado[80]= "rcppm bc aoho gczc aihwzo c vwsfs rs ufojsror";
	char desencriptado[80];
	int clave = 0, salir = 0;
	
	//llamada a función rutaQuid aquí
	usoAscendio = rutaQuid(&acel_x, &acel_y, &acel_z, modeloNimbus, numJugadores, numAtacantes, numDefensores, conjuroPermitido, magiaNegra,
							&vel_x, &vel_y, &vel_z, AscendioHarry);

	//impresión por pantalla de la salida de la función rutaQuid
	printf("Ascendio de Harry %u = %u --> Aceleracion(x,y,z) %lu %lu %lu \n",usoAscendio, AscendioHarry, acel_x, acel_y, acel_z);


	//impresión por pantalla del inicio del ejercicio 2
	printf("\nTarea para desencriptar el mensaje: %s\n", encriptado);

	//código y llamada a la función Decode aquí. Bucle para averiguar la clave de rotación del mensaje
	do{
		printf("Introduzca la clave desencriptar [0-26]:\n");
		scanf("%d", &clave);

		// A RELLENAR POR ALUMNO
		Decode(encriptado, desencriptado, clave);
		
		//impresión por pantalla de la salida de la función Decode
		printf("Desencriptado: rotM=%d Mensaje %s\n",clave,desencriptado);
		
		//opcion de usuario para probar otras rotaciones
		printf("Desea probar otra clave? SI=0/ NO=1\n");
		scanf("%d",&salir);
	}while(salir==0);
	//FIN DEL PROGRAMA en C a implementar por alumno aquí

	return 0;
}
