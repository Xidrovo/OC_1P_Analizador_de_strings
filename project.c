#include <stdio.h>

int compare(char* first, char* second);
int compareChar(char a, char b);
int numPalabras( char* oracion );
int length( char* palabra );
char letraMasGrande( char* palabra );
char letraMasPequena( char* palabra );

int main()
{

    printf( "%i \n", compare("ads", " a sdasdasd") );
    printf( "%i \n", numPalabras( "   La oracion está   al " ) );
    printf( "%i \n", length( "palabra" ) );
    printf( "%c \n", letraMasGrande("abcdefghijklmnopqrsteuvwxyz") );
    printf( "%c \n", letraMasPequena("abcdefghijklmnopqrsteuvwxyz") );
}

//Esta función comparará la palabra first con secon
//Devuelve positivo si first > second
//Devuelve -negativo si first < second
//Devuelve 0 si son iguales
int compare( char* first, char* second ) {
    char* Fptr = first;
    char* Sptr = second;
    int tempComparator = 0;
    
    while( *Fptr != '\0' && *Sptr != '\0' ){
        tempComparator = compareChar( *Fptr, *Sptr );
        if ( tempComparator != 0 ){
            return tempComparator;
        }
        Fptr++;
        Sptr++;
    }
    
    return 0;
}
//Devuelve positivo si a > b
//Devuelve negativo si a < b
//Devuelve 0 si a = b
int compareChar( char a, char b ) {
    return ( int )a - ( int )b;
}
//Retorna el número de palabras que tiene la oración
//(obviamente)
int numPalabras( char* oracion ) {
    char* Optr = oracion;
    int holder = 1;
    int counter = 0;
    while(*Optr != '\0') {
        if (*Optr == ' '){
            holder = 0;
        }else {
            holder++;
        }
        if(holder == 1 && *Optr != ' '){
            counter++;
            holder++;
        }
        Optr++;
    }
    Optr--;
    if(*Optr != ' '){
        counter++;
    }
    return counter;
}
//Retorna la longitud de la palabra
int length( char* palabra ){
    char* ptr = palabra;
    int cont = 0;
    while (*ptr != '\0'){
        cont++;
        ptr++;
    }
    return cont;
}
//Retorna un char con la letra de mayor ASCII
char letraMasGrande( char* palabra ){
    char* ptr = palabra;
    int mayor = 0;
    while( *ptr != '\0'){
        if ( (int) *ptr > mayor ){
            mayor = (int) *ptr;
        }
        ptr++;
    }
    return (char) mayor;
}
//Retorna el char con la letra menor de ASCII
//Considerar que el número mayor en el código ASCII es el 255
char letraMasPequena( char* palabra ){
    char* ptr = palabra;
    int menor = 255;
    while( *ptr != '\0'){
        if ( (int) *ptr < menor ){
            menor = (int) *ptr;
        }
        ptr++;
    }
    return (char) menor;
}


