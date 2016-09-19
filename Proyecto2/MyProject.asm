
_getAscii:

;funciones.c,6 :: 		void getAscii(){
;funciones.c,7 :: 		switch (kp) {
	GOTO       L_getAscii0
;funciones.c,8 :: 		case  2: kp = '1'; break; // 1
L_getAscii2:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,9 :: 		case  3: kp = '2'; break; // 2
L_getAscii3:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,10 :: 		case  4: kp = '3'; break; // 3
L_getAscii4:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,11 :: 		case  6: kp = '4'; break; // 4
L_getAscii5:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,12 :: 		case  7: kp = '5'; break; // 5
L_getAscii6:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,13 :: 		case  8: kp = '6'; break; // 6
L_getAscii7:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,14 :: 		case 10: kp = '7'; break; // 7
L_getAscii8:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,15 :: 		case 11: kp = '8'; break; // 8
L_getAscii9:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,16 :: 		case 12: kp = '9'; break; // 9
L_getAscii10:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,17 :: 		case 14: kp = 'B'; break; // Borrar
L_getAscii11:
	MOVLW      66
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,18 :: 		case 15: kp = '0'; break; // 0
L_getAscii12:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,19 :: 		case 16: kp = 'E'; break; // Enter
L_getAscii13:
	MOVLW      69
	MOVWF      _kp+0
	GOTO       L_getAscii1
;funciones.c,20 :: 		}
L_getAscii0:
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii2
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii3
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii4
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii5
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii6
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii7
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii8
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii9
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii10
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii11
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii12
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_getAscii13
L_getAscii1:
;funciones.c,21 :: 		}
L_end_getAscii:
	RETURN
; end of _getAscii

_agregarDigito:

;funciones.c,24 :: 		short agregarDigito(int N, short bandCero){
;funciones.c,25 :: 		if(kp>='0' && kp <= '9'){ //numeros del 0 al 9
	MOVLW      128
	BTFSC      _kp+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito74
	MOVLW      48
	SUBWF      _kp+0, 0
L__agregarDigito74:
	BTFSS      STATUS+0, 0
	GOTO       L_agregarDigito16
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	BTFSC      _kp+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito75
	MOVF       _kp+0, 0
	SUBLW      57
L__agregarDigito75:
	BTFSS      STATUS+0, 0
	GOTO       L_agregarDigito16
L__agregarDigito70:
;funciones.c,27 :: 		if(digitos == 0 && kp == '0' ){
	MOVF       _digitos+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito19
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito76
	MOVLW      48
	XORWF      _kp+0, 0
L__agregarDigito76:
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito19
L__agregarDigito69:
;funciones.c,28 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_agregarDigito
;funciones.c,29 :: 		}
L_agregarDigito19:
;funciones.c,31 :: 		if(digitos==N){
	MOVLW      0
	BTFSC      _digitos+0, 7
	MOVLW      255
	XORWF      FARG_agregarDigito_N+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito77
	MOVF       FARG_agregarDigito_N+0, 0
	XORWF      _digitos+0, 0
L__agregarDigito77:
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito20
;funciones.c,32 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_agregarDigito
;funciones.c,33 :: 		}
L_agregarDigito20:
;funciones.c,35 :: 		numero = numero*10 + kp -48;
	MOVF       _numero+0, 0
	MOVWF      R0+0
	MOVF       _numero+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp+0, 0
	ADDWF      R0+0, 0
	MOVWF      _numero+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      _numero+1
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	ADDWF      _numero+1, 1
	MOVLW      48
	SUBWF      _numero+0, 1
	BTFSS      STATUS+0, 0
	DECF       _numero+1, 1
;funciones.c,36 :: 		Lcd_Chr(2,3 + digitos, kp);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _digitos+0, 0
	ADDLW      3
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;funciones.c,37 :: 		digitos++; //ingremento el numero de digitos
	INCF       _digitos+0, 1
;funciones.c,38 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_agregarDigito
;funciones.c,39 :: 		}
L_agregarDigito16:
;funciones.c,40 :: 		if(kp == 'B'){ //Borrar
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito78
	MOVLW      66
	XORWF      _kp+0, 0
L__agregarDigito78:
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito21
;funciones.c,41 :: 		if(digitos==0){
	MOVF       _digitos+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito22
;funciones.c,42 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_agregarDigito
;funciones.c,43 :: 		}
L_agregarDigito22:
;funciones.c,44 :: 		numero = numero/10; //le quito un digito
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _numero+0, 0
	MOVWF      R0+0
	MOVF       _numero+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _numero+0
	MOVF       R0+1, 0
	MOVWF      _numero+1
;funciones.c,45 :: 		Lcd_Chr(2,2 + digitos, ' ');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _digitos+0, 0
	ADDLW      2
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      32
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;funciones.c,46 :: 		digitos --;
	DECF       _digitos+0, 1
;funciones.c,47 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_agregarDigito
;funciones.c,48 :: 		}
L_agregarDigito21:
;funciones.c,49 :: 		if(kp == 'E'){
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito79
	MOVLW      69
	XORWF      _kp+0, 0
L__agregarDigito79:
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito23
;funciones.c,50 :: 		if(numero==0){
	MOVLW      0
	XORWF      _numero+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__agregarDigito80
	MOVLW      0
	XORWF      _numero+0, 0
L__agregarDigito80:
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito24
;funciones.c,52 :: 		if(bandCero==1){
	MOVF       FARG_agregarDigito_bandCero+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_agregarDigito25
;funciones.c,53 :: 		return 0;
	CLRF       R0+0
	GOTO       L_end_agregarDigito
;funciones.c,54 :: 		}
L_agregarDigito25:
;funciones.c,56 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_agregarDigito
;funciones.c,57 :: 		}
L_agregarDigito24:
;funciones.c,59 :: 		return 0;
	CLRF       R0+0
	GOTO       L_end_agregarDigito
;funciones.c,60 :: 		}
L_agregarDigito23:
;funciones.c,61 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
;funciones.c,62 :: 		}
L_end_agregarDigito:
	RETURN
; end of _agregarDigito

_pedirNumero:

;funciones.c,66 :: 		int pedirNumero(int N, short bandCero){
;funciones.c,67 :: 		kp=0;
	CLRF       _kp+0
;funciones.c,68 :: 		numero=0;
	CLRF       _numero+0
	CLRF       _numero+1
;funciones.c,69 :: 		digitos=0;
	CLRF       _digitos+0
;funciones.c,70 :: 		do{
L_pedirNumero27:
;funciones.c,71 :: 		do{
L_pedirNumero30:
;funciones.c,72 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;funciones.c,73 :: 		}while(!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_pedirNumero30
;funciones.c,74 :: 		getAscii();
	CALL       _getAscii+0
;funciones.c,75 :: 		}while(agregarDigito(N, bandCero));
	MOVF       FARG_pedirNumero_N+0, 0
	MOVWF      FARG_agregarDigito_N+0
	MOVF       FARG_pedirNumero_N+1, 0
	MOVWF      FARG_agregarDigito_N+1
	MOVF       FARG_pedirNumero_bandCero+0, 0
	MOVWF      FARG_agregarDigito_bandCero+0
	CALL       _agregarDigito+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_pedirNumero27
;funciones.c,76 :: 		return numero;
	MOVF       _numero+0, 0
	MOVWF      R0+0
	MOVF       _numero+1, 0
	MOVWF      R0+1
;funciones.c,77 :: 		}
L_end_pedirNumero:
	RETURN
; end of _pedirNumero

_pedirOpcion:

;funciones.c,79 :: 		short pedirOpcion(){
;funciones.c,80 :: 		kp=0;
	CLRF       _kp+0
;funciones.c,81 :: 		numero=0;
	CLRF       _numero+0
	CLRF       _numero+1
;funciones.c,82 :: 		digitos=0;
	CLRF       _digitos+0
;funciones.c,83 :: 		do{
L_pedirOpcion33:
;funciones.c,84 :: 		do{
L_pedirOpcion36:
;funciones.c,85 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;funciones.c,86 :: 		}while(!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_pedirOpcion36
;funciones.c,87 :: 		getAscii();
	CALL       _getAscii+0
;funciones.c,88 :: 		}while(kp!= 'E' && kp!= 'B');
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pedirOpcion83
	MOVLW      69
	XORWF      _kp+0, 0
L__pedirOpcion83:
	BTFSC      STATUS+0, 2
	GOTO       L__pedirOpcion71
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pedirOpcion84
	MOVLW      66
	XORWF      _kp+0, 0
L__pedirOpcion84:
	BTFSC      STATUS+0, 2
	GOTO       L__pedirOpcion71
	GOTO       L_pedirOpcion33
L__pedirOpcion71:
;funciones.c,89 :: 		kp = (kp=='E')?1:0;
	MOVLW      0
	BTFSC      _kp+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pedirOpcion85
	MOVLW      69
	XORWF      _kp+0, 0
L__pedirOpcion85:
	BTFSS      STATUS+0, 2
	GOTO       L_pedirOpcion41
	MOVLW      1
	MOVWF      ?FLOC___pedirOpcionT38+0
	GOTO       L_pedirOpcion42
L_pedirOpcion41:
	CLRF       ?FLOC___pedirOpcionT38+0
L_pedirOpcion42:
	MOVF       ?FLOC___pedirOpcionT38+0, 0
	MOVWF      _kp+0
;funciones.c,90 :: 		return kp;
	MOVF       ?FLOC___pedirOpcionT38+0, 0
	MOVWF      R0+0
;funciones.c,91 :: 		}
L_end_pedirOpcion:
	RETURN
; end of _pedirOpcion

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,40 :: 		void interrupt(){
;MyProject.c,41 :: 		INTCON.GIE=0;
	BCF        INTCON+0, 7
;MyProject.c,42 :: 		INTCON.INTE=0;
	BCF        INTCON+0, 4
;MyProject.c,43 :: 		INTCON.INTF=0;
	BCF        INTCON+0, 1
;MyProject.c,44 :: 		PORTB.RB7=0;
	BCF        PORTB+0, 7
;MyProject.c,45 :: 		modo=2;
	MOVLW      2
	MOVWF      _modo+0
;MyProject.c,46 :: 		}
L_end_interrupt:
L__interrupt87:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_mensaPedirFondos:

;MyProject.c,49 :: 		void mensaPedirFondos(){
;MyProject.c,50 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,51 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,52 :: 		Lcd_Out(1, 1, "Ingrese dolares:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,53 :: 		Lcd_Out(2, 1, "$");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,54 :: 		}
L_end_mensaPedirFondos:
	RETURN
; end of _mensaPedirFondos

_mensaPedirCentavos:

;MyProject.c,56 :: 		void mensaPedirCentavos(){
;MyProject.c,57 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,58 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,59 :: 		Lcd_Out(1, 1, "Ingrese centavos:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,60 :: 		Lcd_Out(2, 1, "$ 0");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,61 :: 		}
L_end_mensaPedirCentavos:
	RETURN
; end of _mensaPedirCentavos

_mensaPedirItems:

;MyProject.c,63 :: 		void mensaPedirItems(){
;MyProject.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,65 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,66 :: 		Lcd_Out(1, 1, "Num. Items:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,67 :: 		Lcd_Out(2, 1, "# 1");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,68 :: 		}
L_end_mensaPedirItems:
	RETURN
; end of _mensaPedirItems

_mensaEliminar:

;MyProject.c,70 :: 		void mensaEliminar(){
;MyProject.c,71 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,72 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,73 :: 		Lcd_Out(1, 1, "Eliminar?");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,74 :: 		Lcd_Out(2, 1, "No[B]  Si[E]");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,75 :: 		}
L_end_mensaEliminar:
	RETURN
; end of _mensaEliminar

_main:

;MyProject.c,77 :: 		void main() {
;MyProject.c,78 :: 		ANSEL  = 0;
	CLRF       ANSEL+0
;MyProject.c,79 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;MyProject.c,80 :: 		PORTE = 0;
	CLRF       PORTE+0
;MyProject.c,81 :: 		TRISE = 0;
	CLRF       TRISE+0
;MyProject.c,83 :: 		UART1_Init(19200);            // Initialize USART module
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,84 :: 		Keypad_Init();                             // (8 bit, 19200 baud rate, no parity bit...)
	CALL       _Keypad_Init+0
;MyProject.c,85 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,86 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,87 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,88 :: 		Lcd_Out(1,1, "Cargando...");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,90 :: 		for (i=0; i < 255; i++){
	CLRF       _i+0
L_main43:
	MOVLW      255
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main44
;MyProject.c,91 :: 		EEPROM_Write(i,0);
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MyProject.c,90 :: 		for (i=0; i < 255; i++){
	INCF       _i+0, 1
;MyProject.c,92 :: 		}
	GOTO       L_main43
L_main44:
;MyProject.c,94 :: 		mensaPedirFondos();
	CALL       _mensaPedirFondos+0
;MyProject.c,95 :: 		fondos=pedirNumero(3, 0);
	MOVLW      3
	MOVWF      FARG_pedirNumero_N+0
	MOVLW      0
	MOVWF      FARG_pedirNumero_N+1
	CLRF       FARG_pedirNumero_bandCero+0
	CALL       _pedirNumero+0
	MOVF       R0+0, 0
	MOVWF      _fondos+0
	MOVF       R0+1, 0
	MOVWF      _fondos+1
	MOVLW      0
	BTFSC      _fondos+1, 7
	MOVLW      255
	MOVWF      _fondos+2
	MOVWF      _fondos+3
;MyProject.c,96 :: 		fondos = fondos*100;
	MOVF       _fondos+0, 0
	MOVWF      R0+0
	MOVF       _fondos+1, 0
	MOVWF      R0+1
	MOVF       _fondos+2, 0
	MOVWF      R0+2
	MOVF       _fondos+3, 0
	MOVWF      R0+3
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _fondos+0
	MOVF       R0+1, 0
	MOVWF      _fondos+1
	MOVF       R0+2, 0
	MOVWF      _fondos+2
	MOVF       R0+3, 0
	MOVWF      _fondos+3
;MyProject.c,97 :: 		mensaPedirCentavos();
	CALL       _mensaPedirCentavos+0
;MyProject.c,98 :: 		fondos += pedirNumero(2, 1);
	MOVLW      2
	MOVWF      FARG_pedirNumero_N+0
	MOVLW      0
	MOVWF      FARG_pedirNumero_N+1
	MOVLW      1
	MOVWF      FARG_pedirNumero_bandCero+0
	CALL       _pedirNumero+0
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       _fondos+0, 0
	ADDWF      R0+0, 1
	MOVF       _fondos+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _fondos+1, 0
	ADDWF      R0+1, 1
	MOVF       _fondos+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _fondos+2, 0
	ADDWF      R0+2, 1
	MOVF       _fondos+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _fondos+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _fondos+0
	MOVF       R0+1, 0
	MOVWF      _fondos+1
	MOVF       R0+2, 0
	MOVWF      _fondos+2
	MOVF       R0+3, 0
	MOVWF      _fondos+3
;MyProject.c,100 :: 		while(1){
L_main46:
;MyProject.c,101 :: 		escucharSerial();
	CALL       _escucharSerial+0
;MyProject.c,103 :: 		if(modo==2){
	MOVF       _modo+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main48
;MyProject.c,104 :: 		mensaPedirFondos();
	CALL       _mensaPedirFondos+0
;MyProject.c,105 :: 		fondos = pedirNumero(3, 0);
	MOVLW      3
	MOVWF      FARG_pedirNumero_N+0
	MOVLW      0
	MOVWF      FARG_pedirNumero_N+1
	CLRF       FARG_pedirNumero_bandCero+0
	CALL       _pedirNumero+0
	MOVF       R0+0, 0
	MOVWF      _fondos+0
	MOVF       R0+1, 0
	MOVWF      _fondos+1
	MOVLW      0
	BTFSC      _fondos+1, 7
	MOVLW      255
	MOVWF      _fondos+2
	MOVWF      _fondos+3
;MyProject.c,106 :: 		fondos = fondos*100;
	MOVF       _fondos+0, 0
	MOVWF      R0+0
	MOVF       _fondos+1, 0
	MOVWF      R0+1
	MOVF       _fondos+2, 0
	MOVWF      R0+2
	MOVF       _fondos+3, 0
	MOVWF      R0+3
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _fondos+0
	MOVF       R0+1, 0
	MOVWF      _fondos+1
	MOVF       R0+2, 0
	MOVWF      _fondos+2
	MOVF       R0+3, 0
	MOVWF      _fondos+3
;MyProject.c,107 :: 		mensaPedirCentavos();
	CALL       _mensaPedirCentavos+0
;MyProject.c,108 :: 		fondos += pedirNumero(2, 1);
	MOVLW      2
	MOVWF      FARG_pedirNumero_N+0
	MOVLW      0
	MOVWF      FARG_pedirNumero_N+1
	MOVLW      1
	MOVWF      FARG_pedirNumero_bandCero+0
	CALL       _pedirNumero+0
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       _fondos+0, 0
	ADDWF      R0+0, 1
	MOVF       _fondos+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _fondos+1, 0
	ADDWF      R0+1, 1
	MOVF       _fondos+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _fondos+2, 0
	ADDWF      R0+2, 1
	MOVF       _fondos+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _fondos+3, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _fondos+0
	MOVF       R0+1, 0
	MOVWF      _fondos+1
	MOVF       R0+2, 0
	MOVWF      _fondos+2
	MOVF       R0+3, 0
	MOVWF      _fondos+3
;MyProject.c,110 :: 		modo=1;//cambio a modo serial
	MOVLW      1
	MOVWF      _modo+0
;MyProject.c,111 :: 		}
L_main48:
;MyProject.c,113 :: 		}
	GOTO       L_main46
;MyProject.c,115 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_escucharSerial:

;MyProject.c,118 :: 		void escucharSerial(){
;MyProject.c,119 :: 		modo=1;
	MOVLW      1
	MOVWF      _modo+0
;MyProject.c,120 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;MyProject.c,121 :: 		INTCON.INTE=1;
	BSF        INTCON+0, 4
;MyProject.c,122 :: 		INTCON.INTF=0;
	BCF        INTCON+0, 1
;MyProject.c,123 :: 		PORTB.RB7=1;
	BSF        PORTB+0, 7
;MyProject.c,124 :: 		mostrarFondo();
	CALL       _mostrarFondo+0
;MyProject.c,126 :: 		while(modo==1){
L_escucharSerial49:
	MOVF       _modo+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_escucharSerial50
;MyProject.c,127 :: 		if(bytesLeidos==16){
	MOVF       _bytesLeidos+0, 0
	XORLW      16
	BTFSS      STATUS+0, 2
	GOTO       L_escucharSerial51
;MyProject.c,128 :: 		index = buffer[0];
	MOVF       _buffer+0, 0
	MOVWF      _index+0
;MyProject.c,130 :: 		precio =  (long)10000*(buffer[1]-48);
	MOVLW      48
	SUBWF      _buffer+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVLW      16
	MOVWF      R4+0
	MOVLW      39
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__escucharSerial+0
	MOVF       R0+1, 0
	MOVWF      FLOC__escucharSerial+1
	MOVF       R0+2, 0
	MOVWF      FLOC__escucharSerial+2
	MOVF       R0+3, 0
	MOVWF      FLOC__escucharSerial+3
	MOVF       FLOC__escucharSerial+0, 0
	MOVWF      _precio+0
	MOVF       FLOC__escucharSerial+1, 0
	MOVWF      _precio+1
	MOVF       FLOC__escucharSerial+2, 0
	MOVWF      _precio+2
	MOVF       FLOC__escucharSerial+3, 0
	MOVWF      _precio+3
;MyProject.c,131 :: 		precio += (long)1000*(buffer[2]-48);
	MOVLW      48
	SUBWF      _buffer+2, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       FLOC__escucharSerial+0, 0
	MOVWF      _precio+0
	MOVF       FLOC__escucharSerial+1, 0
	MOVWF      _precio+1
	MOVF       FLOC__escucharSerial+2, 0
	MOVWF      _precio+2
	MOVF       FLOC__escucharSerial+3, 0
	MOVWF      _precio+3
	MOVF       R0+0, 0
	ADDWF      _precio+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      _precio+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      _precio+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      _precio+3, 1
;MyProject.c,132 :: 		precio += (long)100*(buffer[3]-48);
	MOVLW      48
	SUBWF      _buffer+3, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	ADDWF      _precio+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      _precio+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      _precio+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      _precio+3, 1
;MyProject.c,133 :: 		precio += (long)10*(buffer[4]-48);
	MOVLW      48
	SUBWF      _buffer+4, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	ADDWF      _precio+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      _precio+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      _precio+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      _precio+3, 1
;MyProject.c,134 :: 		precio += (long)(buffer[5]-48);
	MOVLW      48
	SUBWF      _buffer+5, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       R0+0, 0
	ADDWF      _precio+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      _precio+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      _precio+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      _precio+3, 1
;MyProject.c,135 :: 		bytesLeidos=0;
	CLRF       _bytesLeidos+0
;MyProject.c,136 :: 		mostrarProducto();
	CALL       _mostrarProducto+0
;MyProject.c,137 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_escucharSerial52:
	DECFSZ     R13+0, 1
	GOTO       L_escucharSerial52
	DECFSZ     R12+0, 1
	GOTO       L_escucharSerial52
	DECFSZ     R11+0, 1
	GOTO       L_escucharSerial52
	NOP
;MyProject.c,139 :: 		i = EEPROM_Read(index); //i = el numero de productos ingresados
	MOVF       _index+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _i+0
;MyProject.c,140 :: 		Lcd_Chr(1,1,i+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,141 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_escucharSerial53:
	DECFSZ     R13+0, 1
	GOTO       L_escucharSerial53
	DECFSZ     R12+0, 1
	GOTO       L_escucharSerial53
	DECFSZ     R11+0, 1
	GOTO       L_escucharSerial53
	NOP
;MyProject.c,142 :: 		op=0; //no elimnar por defecto
	CLRF       _op+0
;MyProject.c,143 :: 		if(i>0){
	MOVF       _i+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_escucharSerial54
;MyProject.c,144 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,145 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,146 :: 		Lcd_Out(1, 1, "Eliminar?");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,148 :: 		op = pedirOpcion();
	CALL       _pedirOpcion+0
	MOVF       R0+0, 0
	MOVWF      _op+0
;MyProject.c,151 :: 		}
L_escucharSerial54:
;MyProject.c,153 :: 		mensaPedirItems();
	CALL       _mensaPedirItems+0
;MyProject.c,154 :: 		numItems = pedirNumero(2, 1);
	MOVLW      2
	MOVWF      FARG_pedirNumero_N+0
	MOVLW      0
	MOVWF      FARG_pedirNumero_N+1
	MOVLW      1
	MOVWF      FARG_pedirNumero_bandCero+0
	CALL       _pedirNumero+0
	MOVF       R0+0, 0
	MOVWF      _numItems+0
;MyProject.c,155 :: 		numItems = (numItems == 0)?1:numItems;
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_escucharSerial55
	MOVLW      1
	MOVWF      ?FLOC___escucharSerialT101+0
	GOTO       L_escucharSerial56
L_escucharSerial55:
	MOVF       _numItems+0, 0
	MOVWF      ?FLOC___escucharSerialT101+0
L_escucharSerial56:
	MOVF       ?FLOC___escucharSerialT101+0, 0
	MOVWF      _numItems+0
;MyProject.c,156 :: 		if(op==0){
	MOVF       _op+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_escucharSerial57
;MyProject.c,158 :: 		gastado += numItems*precio;
	MOVF       _numItems+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       _precio+0, 0
	MOVWF      R4+0
	MOVF       _precio+1, 0
	MOVWF      R4+1
	MOVF       _precio+2, 0
	MOVWF      R4+2
	MOVF       _precio+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	ADDWF      _gastado+0, 1
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+1, 0
	ADDWF      _gastado+1, 1
	MOVF       R0+2, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+2, 0
	ADDWF      _gastado+2, 1
	MOVF       R0+3, 0
	BTFSC      STATUS+0, 0
	INCFSZ     R0+3, 0
	ADDWF      _gastado+3, 1
;MyProject.c,159 :: 		i+=numItems; //se incrementa el numero de items
	MOVF       _numItems+0, 0
	ADDWF      _i+0, 1
;MyProject.c,160 :: 		}
L_escucharSerial57:
;MyProject.c,161 :: 		if(op==1){//eliminar
	MOVF       _op+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_escucharSerial58
;MyProject.c,166 :: 		numItems = (numItems>i)?i:numItems;
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	BTFSC      _numItems+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__escucharSerial94
	MOVF       _numItems+0, 0
	SUBWF      _i+0, 0
L__escucharSerial94:
	BTFSC      STATUS+0, 0
	GOTO       L_escucharSerial59
	MOVF       _i+0, 0
	MOVWF      ?FLOC___escucharSerialT108+0
	GOTO       L_escucharSerial60
L_escucharSerial59:
	MOVF       _numItems+0, 0
	MOVWF      ?FLOC___escucharSerialT108+0
L_escucharSerial60:
	MOVF       ?FLOC___escucharSerialT108+0, 0
	MOVWF      _numItems+0
;MyProject.c,167 :: 		gastado -= numItems*precio;//se disminuye lo gastado
	MOVF       ?FLOC___escucharSerialT108+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	MOVWF      R0+2
	MOVWF      R0+3
	MOVF       _precio+0, 0
	MOVWF      R4+0
	MOVF       _precio+1, 0
	MOVWF      R4+1
	MOVF       _precio+2, 0
	MOVWF      R4+2
	MOVF       _precio+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	SUBWF      _gastado+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      _gastado+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      _gastado+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      _gastado+3, 1
;MyProject.c,168 :: 		i-= numItems;
	MOVF       ?FLOC___escucharSerialT108+0, 0
	SUBWF      _i+0, 1
;MyProject.c,169 :: 		}
L_escucharSerial58:
;MyProject.c,171 :: 		EEPROM_Write(index, i);
	MOVF       _index+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MyProject.c,173 :: 		break;
	GOTO       L_escucharSerial50
;MyProject.c,174 :: 		}
L_escucharSerial51:
;MyProject.c,176 :: 		if(UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_escucharSerial61
;MyProject.c,177 :: 		i = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _i+0
;MyProject.c,178 :: 		buffer[bytesLeidos]= i;
	MOVF       _bytesLeidos+0, 0
	ADDLW      _buffer+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,179 :: 		bytesLeidos++;
	INCF       _bytesLeidos+0, 1
;MyProject.c,180 :: 		UART1_Write(i);// and send it back
	MOVF       _i+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,181 :: 		}
L_escucharSerial61:
;MyProject.c,182 :: 		}
	GOTO       L_escucharSerial49
L_escucharSerial50:
;MyProject.c,183 :: 		}
L_end_escucharSerial:
	RETURN
; end of _escucharSerial

_mostrarFondo:

;MyProject.c,185 :: 		void mostrarFondo(){
;MyProject.c,186 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,187 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,188 :: 		Lcd_Out(1, 1, "Fondos:$");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,189 :: 		Lcd_Out(2, 1, "Exceso:$");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,191 :: 		if(fondos - gastado > 0){
	MOVF       _fondos+0, 0
	MOVWF      R1+0
	MOVF       _fondos+1, 0
	MOVWF      R1+1
	MOVF       _fondos+2, 0
	MOVWF      R1+2
	MOVF       _fondos+3, 0
	MOVWF      R1+3
	MOVF       _gastado+0, 0
	SUBWF      R1+0, 1
	MOVF       _gastado+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _gastado+1, 0
	SUBWF      R1+1, 1
	MOVF       _gastado+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _gastado+2, 0
	SUBWF      R1+2, 1
	MOVF       _gastado+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     _gastado+3, 0
	SUBWF      R1+3, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__mostrarFondo96
	MOVF       R1+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__mostrarFondo96
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__mostrarFondo96
	MOVF       R1+0, 0
	SUBLW      0
L__mostrarFondo96:
	BTFSC      STATUS+0, 0
	GOTO       L_mostrarFondo62
;MyProject.c,192 :: 		imprimirDecimal(fondos - gastado, 1,9);
	MOVF       _gastado+0, 0
	MOVWF      R0+0
	MOVF       _gastado+1, 0
	MOVWF      R0+1
	MOVF       _gastado+2, 0
	MOVWF      R0+2
	MOVF       _gastado+3, 0
	MOVWF      R0+3
	MOVF       _fondos+0, 0
	MOVWF      FARG_imprimirDecimal_decimal+0
	MOVF       _fondos+1, 0
	MOVWF      FARG_imprimirDecimal_decimal+1
	MOVF       _fondos+2, 0
	MOVWF      FARG_imprimirDecimal_decimal+2
	MOVF       _fondos+3, 0
	MOVWF      FARG_imprimirDecimal_decimal+3
	MOVF       R0+0, 0
	SUBWF      FARG_imprimirDecimal_decimal+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      FARG_imprimirDecimal_decimal+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      FARG_imprimirDecimal_decimal+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      FARG_imprimirDecimal_decimal+3, 1
	MOVLW      1
	MOVWF      FARG_imprimirDecimal_fila+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_fila+1
	MOVLW      9
	MOVWF      FARG_imprimirDecimal_columna+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_columna+1
	CALL       _imprimirDecimal+0
;MyProject.c,193 :: 		imprimirDecimal(0, 2,9);
	CLRF       FARG_imprimirDecimal_decimal+0
	CLRF       FARG_imprimirDecimal_decimal+1
	CLRF       FARG_imprimirDecimal_decimal+2
	CLRF       FARG_imprimirDecimal_decimal+3
	MOVLW      2
	MOVWF      FARG_imprimirDecimal_fila+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_fila+1
	MOVLW      9
	MOVWF      FARG_imprimirDecimal_columna+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_columna+1
	CALL       _imprimirDecimal+0
;MyProject.c,194 :: 		PORTE = 2;
	MOVLW      2
	MOVWF      PORTE+0
;MyProject.c,195 :: 		}
	GOTO       L_mostrarFondo63
L_mostrarFondo62:
;MyProject.c,197 :: 		imprimirDecimal(0, 1, 9);
	CLRF       FARG_imprimirDecimal_decimal+0
	CLRF       FARG_imprimirDecimal_decimal+1
	CLRF       FARG_imprimirDecimal_decimal+2
	CLRF       FARG_imprimirDecimal_decimal+3
	MOVLW      1
	MOVWF      FARG_imprimirDecimal_fila+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_fila+1
	MOVLW      9
	MOVWF      FARG_imprimirDecimal_columna+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_columna+1
	CALL       _imprimirDecimal+0
;MyProject.c,198 :: 		imprimirDecimal(gastado-fondos, 2,9);
	MOVF       _fondos+0, 0
	MOVWF      R0+0
	MOVF       _fondos+1, 0
	MOVWF      R0+1
	MOVF       _fondos+2, 0
	MOVWF      R0+2
	MOVF       _fondos+3, 0
	MOVWF      R0+3
	MOVF       _gastado+0, 0
	MOVWF      FARG_imprimirDecimal_decimal+0
	MOVF       _gastado+1, 0
	MOVWF      FARG_imprimirDecimal_decimal+1
	MOVF       _gastado+2, 0
	MOVWF      FARG_imprimirDecimal_decimal+2
	MOVF       _gastado+3, 0
	MOVWF      FARG_imprimirDecimal_decimal+3
	MOVF       R0+0, 0
	SUBWF      FARG_imprimirDecimal_decimal+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      FARG_imprimirDecimal_decimal+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      FARG_imprimirDecimal_decimal+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      FARG_imprimirDecimal_decimal+3, 1
	MOVLW      2
	MOVWF      FARG_imprimirDecimal_fila+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_fila+1
	MOVLW      9
	MOVWF      FARG_imprimirDecimal_columna+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_columna+1
	CALL       _imprimirDecimal+0
;MyProject.c,199 :: 		PORTE= 1;
	MOVLW      1
	MOVWF      PORTE+0
;MyProject.c,200 :: 		}
L_mostrarFondo63:
;MyProject.c,202 :: 		}
L_end_mostrarFondo:
	RETURN
; end of _mostrarFondo

_imprimirDecimal:

;MyProject.c,204 :: 		void imprimirDecimal(long int decimal, int fila, int columna){
;MyProject.c,205 :: 		txt[6]= 0;
	CLRF       _txt+6
;MyProject.c,206 :: 		for(i=0; i< 2; i++){
	CLRF       _i+0
L_imprimirDecimal64:
	MOVLW      2
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_imprimirDecimal65
;MyProject.c,207 :: 		txt[5-i] = decimal%10 + 48;
	MOVF       _i+0, 0
	SUBLW      5
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _txt+0
	MOVWF      FLOC__imprimirDecimal+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FARG_imprimirDecimal_decimal+0, 0
	MOVWF      R0+0
	MOVF       FARG_imprimirDecimal_decimal+1, 0
	MOVWF      R0+1
	MOVF       FARG_imprimirDecimal_decimal+2, 0
	MOVWF      R0+2
	MOVF       FARG_imprimirDecimal_decimal+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__imprimirDecimal+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,208 :: 		decimal = decimal/10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FARG_imprimirDecimal_decimal+0, 0
	MOVWF      R0+0
	MOVF       FARG_imprimirDecimal_decimal+1, 0
	MOVWF      R0+1
	MOVF       FARG_imprimirDecimal_decimal+2, 0
	MOVWF      R0+2
	MOVF       FARG_imprimirDecimal_decimal+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_imprimirDecimal_decimal+0
	MOVF       R0+1, 0
	MOVWF      FARG_imprimirDecimal_decimal+1
	MOVF       R0+2, 0
	MOVWF      FARG_imprimirDecimal_decimal+2
	MOVF       R0+3, 0
	MOVWF      FARG_imprimirDecimal_decimal+3
;MyProject.c,206 :: 		for(i=0; i< 2; i++){
	INCF       _i+0, 1
;MyProject.c,209 :: 		}
	GOTO       L_imprimirDecimal64
L_imprimirDecimal65:
;MyProject.c,210 :: 		txt[3]= '.';
	MOVLW      46
	MOVWF      _txt+3
;MyProject.c,211 :: 		txt[2]= '0';
	MOVLW      48
	MOVWF      _txt+2
;MyProject.c,212 :: 		txt[1] = ' ';
	MOVLW      32
	MOVWF      _txt+1
;MyProject.c,213 :: 		txt[0] = ' ';
	MOVLW      32
	MOVWF      _txt+0
;MyProject.c,214 :: 		i=0;
	CLRF       _i+0
;MyProject.c,215 :: 		while(decimal!=0){
L_imprimirDecimal67:
	MOVLW      0
	MOVWF      R0+0
	XORWF      FARG_imprimirDecimal_decimal+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__imprimirDecimal98
	MOVF       R0+0, 0
	XORWF      FARG_imprimirDecimal_decimal+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__imprimirDecimal98
	MOVF       R0+0, 0
	XORWF      FARG_imprimirDecimal_decimal+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__imprimirDecimal98
	MOVF       FARG_imprimirDecimal_decimal+0, 0
	XORLW      0
L__imprimirDecimal98:
	BTFSC      STATUS+0, 2
	GOTO       L_imprimirDecimal68
;MyProject.c,216 :: 		txt[2-i] = decimal%10 + 48;
	MOVF       _i+0, 0
	SUBLW      2
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _txt+0
	MOVWF      FLOC__imprimirDecimal+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FARG_imprimirDecimal_decimal+0, 0
	MOVWF      R0+0
	MOVF       FARG_imprimirDecimal_decimal+1, 0
	MOVWF      R0+1
	MOVF       FARG_imprimirDecimal_decimal+2, 0
	MOVWF      R0+2
	MOVF       FARG_imprimirDecimal_decimal+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__imprimirDecimal+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,217 :: 		decimal= decimal/10;
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FARG_imprimirDecimal_decimal+0, 0
	MOVWF      R0+0
	MOVF       FARG_imprimirDecimal_decimal+1, 0
	MOVWF      R0+1
	MOVF       FARG_imprimirDecimal_decimal+2, 0
	MOVWF      R0+2
	MOVF       FARG_imprimirDecimal_decimal+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_imprimirDecimal_decimal+0
	MOVF       R0+1, 0
	MOVWF      FARG_imprimirDecimal_decimal+1
	MOVF       R0+2, 0
	MOVWF      FARG_imprimirDecimal_decimal+2
	MOVF       R0+3, 0
	MOVWF      FARG_imprimirDecimal_decimal+3
;MyProject.c,218 :: 		i++;
	INCF       _i+0, 1
;MyProject.c,219 :: 		}
	GOTO       L_imprimirDecimal67
L_imprimirDecimal68:
;MyProject.c,221 :: 		Lcd_Out(fila, columna, txt);
	MOVF       FARG_imprimirDecimal_fila+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       FARG_imprimirDecimal_columna+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,222 :: 		}
L_end_imprimirDecimal:
	RETURN
; end of _imprimirDecimal

_mostrarProducto:

;MyProject.c,224 :: 		void mostrarProducto(){
;MyProject.c,227 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,228 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,229 :: 		Lcd_Out(1,1, &buffer[6]);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _buffer+6
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,230 :: 		Lcd_Chr(2,1, '$');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      36
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,231 :: 		imprimirDecimal(precio, 2 , 2);
	MOVF       _precio+0, 0
	MOVWF      FARG_imprimirDecimal_decimal+0
	MOVF       _precio+1, 0
	MOVWF      FARG_imprimirDecimal_decimal+1
	MOVF       _precio+2, 0
	MOVWF      FARG_imprimirDecimal_decimal+2
	MOVF       _precio+3, 0
	MOVWF      FARG_imprimirDecimal_decimal+3
	MOVLW      2
	MOVWF      FARG_imprimirDecimal_fila+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_fila+1
	MOVLW      2
	MOVWF      FARG_imprimirDecimal_columna+0
	MOVLW      0
	MOVWF      FARG_imprimirDecimal_columna+1
	CALL       _imprimirDecimal+0
;MyProject.c,233 :: 		}
L_end_mostrarProducto:
	RETURN
; end of _mostrarProducto
