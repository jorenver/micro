int numero =0; //numero ingresado por teclado
short digitos = 0; //contador de digitos ingresados
short kp = 0; //tecla presionada


void getAscii(){
     switch (kp) {
      case  2: kp = '1'; break; // 1
      case  3: kp = '2'; break; // 2
      case  4: kp = '3'; break; // 3
      case  6: kp = '4'; break; // 4
      case  7: kp = '5'; break; // 5
      case  8: kp = '6'; break; // 6
      case 10: kp = '7'; break; // 7
      case 11: kp = '8'; break; // 8
      case 12: kp = '9'; break; // 9
      case 14: kp = 'B'; break; // Borrar
      case 15: kp = '0'; break; // 0
      case 16: kp = 'E'; break; // Enter
    }
}


short agregarDigito(int N, short bandCero){
    if(kp>='0' && kp <= '9'){ //numeros del 0 al 9
          //la primera vez no se puede ingresar 0
          if(digitos == 0 && kp == '0' ){
              return 1;
          }
          //se admiten maximo 4 digitos
          if(digitos==N){
              return 1;
          }
          //se calcula el numero
          numero = numero*10 + kp -48;
          Lcd_Chr(2,3 + digitos, kp);
          digitos++; //ingremento el numero de digitos
          return 1;
      }
      if(kp == 'B'){ //Borrar
            if(digitos==0){
               return 1;
            }
            numero = numero/10; //le quito un digito
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

//si bandCero = 1 se puede ingresar cero
//si bandCero = 0 no se puede ingresar cero
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