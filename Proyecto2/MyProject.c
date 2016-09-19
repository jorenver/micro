#include "funciones.c"

char  keypadPort at PORTB; //teclado en PORTB

//Configuracion LCD en PORTD
sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;

sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;

unsigned short i;
unsigned short index;

//variables
long int fondos = -1;  //fondos de la persona
long int precio = 0;  //precio de un producto
long int gastado = 0; //lo gastado
long int gastadoTemp=0; //gastado temporal
short modo=2; //1: modo serial, 2: fondos; 3:cantidad
short numItems = 1; //numero de items ingresados o retirados
char buffer[26]; //buffer
char txt[10]; //char de texto
short bytesLeidos=0;
short op; //opcion de eliminar 0=No 1=Si

void mostrarFondo();
void escucharSerial();
void mostrarProducto();
void imprimirDecimal(long int decimal, int fila, int columna);

void interrupt(){
     INTCON.GIE=0;
     INTCON.INTE=0;
     INTCON.INTF=0;
     PORTB.RB7=0;
     modo=2;
}


void mensaPedirFondos(){
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1, 1, "Ingrese dolares:");
     Lcd_Out(2, 1, "$");
}

void mensaPedirCentavos(){
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1, 1, "Ingrese centavos:");
     Lcd_Out(2, 1, "$ 0");
}

void mensaPedirItems(){
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1, 1, "Num. Items:");
     Lcd_Out(2, 1, "# 1");
}

void mensaEliminar(){
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1, 1, "Eliminar?");
     Lcd_Out(2, 1, "No[B]  Si[E]");
}

void main() {
    ANSEL  = 0;
    ANSELH = 0;
    PORTE = 0;
    TRISE = 0;
    
    UART1_Init(19200);            // Initialize USART module
    Keypad_Init();                             // (8 bit, 19200 baud rate, no parity bit...)
    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Out(1,1, "Cargando...");
    //limpiar eeprom llenarla de ceros
    for (i=0; i < 255; i++){
        EEPROM_Write(i,0);
    }
    
    mensaPedirFondos();
    fondos=pedirNumero(3, 0);
    fondos = fondos*100;
    mensaPedirCentavos();
    fondos += pedirNumero(2, 1);

    while(1){
         escucharSerial();
         // nuevo fondo
         if(modo==2){
             mensaPedirFondos();
             fondos = pedirNumero(3, 0);
             fondos = fondos*100;
             mensaPedirCentavos();
             fondos += pedirNumero(2, 1);
             
             modo=1;//cambio a modo serial
         }

     }

}


void escucharSerial(){
     modo=1;
     INTCON.GIE=1;
     INTCON.INTE=1;
     INTCON.INTF=0;
     PORTB.RB7=1;
     mostrarFondo();
     //repite mientras el modo sea serial
     while(modo==1){
        if(bytesLeidos==16){
           index = buffer[0];
          //calcula el precio
          precio =  (long)10000*(buffer[1]-48);
          precio += (long)1000*(buffer[2]-48);
          precio += (long)100*(buffer[3]-48);
          precio += (long)10*(buffer[4]-48);
          precio += (long)(buffer[5]-48);
          bytesLeidos=0;
          mostrarProducto();
          Delay_ms(2000);
          //validar si el producto no se ingreso antes
          i = EEPROM_Read(index); //i = el numero de productos ingresados
          Lcd_Chr(1,1,i+48);
          Delay_ms(2000);
          op=0; //no elimnar por defecto
          if(i>0){
            Lcd_Cmd(_LCD_CLEAR);
            Lcd_Cmd(_LCD_CURSOR_OFF);
            Lcd_Out(1, 1, "Eliminar?");
            //Lcd_Out(2, 1, "No Si");
            op = pedirOpcion();
            //op=1 eliminar
            //op=0 no eliminar
          }

          mensaPedirItems();
          numItems = pedirNumero(2, 1);
          numItems = (numItems == 0)?1:numItems;
          if(op==0){
               //no eliminar se aumenta lo gastado
               gastado += numItems*precio;
               i+=numItems; //se incrementa el numero de items
          }
          if(op==1){//eliminar
               //si el numero de items ingresados es mayor
               //al numero de items que hay en la eeprom
               //entonces el numero de items ingresados sera igual
               //al numero de items que hay en la eeeprom
               numItems = (numItems>i)?i:numItems;
               gastado -= numItems*precio;//se disminuye lo gastado
               i-= numItems;
          }

          EEPROM_Write(index, i);

          break;
        }
        //leer 1 byte
        if(UART1_Data_Ready()){
            i = UART1_Read();
            buffer[bytesLeidos]= i;
            bytesLeidos++;
            UART1_Write(i);// and send it back
        }
     }
}

void mostrarFondo(){
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Out(1, 1, "Fondos:$");
    Lcd_Out(2, 1, "Exceso:$");
    
    if(fondos - gastado > 0){
        imprimirDecimal(fondos - gastado, 1,9);
        imprimirDecimal(0, 2,9);
        PORTE = 2;
    }
    else{
         imprimirDecimal(0, 1, 9);
         imprimirDecimal(gastado-fondos, 2,9);
         PORTE= 1;
    }

}

void imprimirDecimal(long int decimal, int fila, int columna){
     txt[6]= 0;
     for(i=0; i< 2; i++){
        txt[5-i] = decimal%10 + 48;
        decimal = decimal/10;
     }
     txt[3]= '.';
     txt[2]= '0';
     txt[1] = ' ';
     txt[0] = ' ';
     i=0;
     while(decimal!=0){
        txt[2-i] = decimal%10 + 48;
        decimal= decimal/10;
        i++;
     }
     
     Lcd_Out(fila, columna, txt);
}

void mostrarProducto(){

     //actulizo la pantalla
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1,1, &buffer[6]);
     Lcd_Chr(2,1, '$');
     imprimirDecimal(precio, 2 , 2);

}