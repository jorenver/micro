#line 1 "C:/Users/jorge/Documents/oswaldo/Proyecto2/MyProject.c"
#line 1 "c:/users/jorge/documents/oswaldo/proyecto2/funciones.c"
int numero =0;
short digitos = 0;
short kp = 0;


void getAscii(){
 switch (kp) {
 case 2: kp = '1'; break;
 case 3: kp = '2'; break;
 case 4: kp = '3'; break;
 case 6: kp = '4'; break;
 case 7: kp = '5'; break;
 case 8: kp = '6'; break;
 case 10: kp = '7'; break;
 case 11: kp = '8'; break;
 case 12: kp = '9'; break;
 case 14: kp = 'B'; break;
 case 15: kp = '0'; break;
 case 16: kp = 'E'; break;
 }
}


short agregarDigito(int N, short bandCero){
 if(kp>='0' && kp <= '9'){

 if(digitos == 0 && kp == '0' ){
 return 1;
 }

 if(digitos==N){
 return 1;
 }

 numero = numero*10 + kp -48;
 Lcd_Chr(2,3 + digitos, kp);
 digitos++;
 return 1;
 }
 if(kp == 'B'){
 if(digitos==0){
 return 1;
 }
 numero = numero/10;
 Lcd_Chr(2,2 + digitos, ' ');
 digitos --;
 return 1;
 }
 if(kp == 'E'){
 if(numero==0){

 if(bandCero==1){
 return 0;
 }

 return 1;
 }
 else
 return 0;
 }
 return 1;
}



int pedirNumero(int N, short bandCero){
 kp=0;
 numero=0;
 digitos=0;
 do{
 do{
 kp = Keypad_Key_Click();
 }while(!kp);
 getAscii();
 }while(agregarDigito(N, bandCero));
 return numero;
}
#line 3 "C:/Users/jorge/Documents/oswaldo/Proyecto2/MyProject.c"
char keypadPort at PORTB;


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


long int fondos = -1;
long int precio = 0;
long int gastado = 0;
short modo=2;
short numItems = 1;
char buffer[26];
char txt[10];
short bytesLeidos=0;

void Inicializar();
int int pedirNumero(int N, short bandCero);
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
 ANSEL = 0;
 ANSELH = 0;
 PORTE = 0;
 TRISE = 0;
 OSCCON = 0B01111100;
 buffer[17]='\0';

 UART1_Init(9600);
 Keypad_Init();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1, "Cargando...");

 for (i=0; i < 255; i++){
 EEPROM_Write(i,0);
 }
 modo=2;
 while(1){
 if(modo==1)
 escucharSerial();

 if(modo==2){
 mensaPedirFondos();
 fondos = pedirNumero(3, 0);
 fondos = fondos*100;
 mensaPedirCentavos();
 fondos += pedirNumero(2, 1);
 modo=1;
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

 while(modo==1){
 if(bytesLeidos==16){
 index = buffer[0];

 precio = (long)10000*(buffer[1]-48);
 precio += (long)1000*(buffer[2]-48);
 precio += (long)100*(buffer[3]-48);
 precio += (long)10*(buffer[4]-48);
 precio += (long)(buffer[5]-48);
 bytesLeidos=0;
 mostrarProducto();
 Delay_ms(2000);

 i = EEPROM_Read(index);
 Lcd_Chr(1,1,i+48);
 Delay_ms(2000);
 if(i>0){
 PORTE=1;


 Delay_ms(2000);
 }

 mensaPedirItems();
 numItems = pedirNumero(2, 1);
 numItems = (numItems == 0)?1:numItems;
 gastado += numItems*precio;


 i = EEPROM_Read(buffer[0]);
 i+=numItems;
 EEPROM_Write(buffer[0], i);

 break;
 }

 if(UART1_Data_Ready()){
 i = UART1_Read();
 buffer[bytesLeidos]= i;
 bytesLeidos++;
 UART1_Write(i);
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


 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1, &buffer[6]);
 Lcd_Chr(2,1, '$');
 imprimirDecimal(precio, 2 , 2);

}
