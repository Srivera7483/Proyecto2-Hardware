
_Escribir_Digito:

;voltimetro.mpas,6 :: 		begin
;voltimetro.mpas,7 :: 		UART_Write_Char(Chr(valor + 48));
	MOVLW      48
	ADDWF      FARG_Escribir_Digito_valor+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,8 :: 		end;
L_end_Escribir_Digito:
	RETURN
; end of _Escribir_Digito

_Escribir_Canal:

;voltimetro.mpas,15 :: 		begin
;voltimetro.mpas,16 :: 		Voltaje_Digitos(adc_raw, entero, dec1, dec2);
	MOVF       FARG_Escribir_Canal_adc_raw+0, 0
	MOVWF      FARG_Voltaje_Digitos_adc_raw+0
	MOVF       FARG_Escribir_Canal_adc_raw+1, 0
	MOVWF      FARG_Voltaje_Digitos_adc_raw+1
	MOVLW      Escribir_Canal_entero+0
	MOVWF      FARG_Voltaje_Digitos_entero+0
	MOVLW      Escribir_Canal_dec1+0
	MOVWF      FARG_Voltaje_Digitos_dec1+0
	MOVLW      Escribir_Canal_dec2+0
	MOVWF      FARG_Voltaje_Digitos_dec2+0
	CALL       _Voltaje_Digitos+0
;voltimetro.mpas,18 :: 		UART_Write_Char('C');
	MOVLW      67
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,19 :: 		UART_Write_Char('H');
	MOVLW      72
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,20 :: 		UART_Write_Char('N');
	MOVLW      78
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,21 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,22 :: 		Escribir_Digito(canal);
	MOVF       FARG_Escribir_Canal_canal+0, 0
	MOVWF      FARG_Escribir_Digito_valor+0
	CALL       _Escribir_Digito+0
;voltimetro.mpas,23 :: 		UART_Write_Char(':');
	MOVLW      58
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,24 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,25 :: 		Escribir_Digito(entero);
	MOVF       Escribir_Canal_entero+0, 0
	MOVWF      FARG_Escribir_Digito_valor+0
	CALL       _Escribir_Digito+0
;voltimetro.mpas,26 :: 		UART_Write_Char('.');
	MOVLW      46
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,27 :: 		Escribir_Digito(dec1);
	MOVF       Escribir_Canal_dec1+0, 0
	MOVWF      FARG_Escribir_Digito_valor+0
	CALL       _Escribir_Digito+0
;voltimetro.mpas,28 :: 		Escribir_Digito(dec2);
	MOVF       Escribir_Canal_dec2+0, 0
	MOVWF      FARG_Escribir_Digito_valor+0
	CALL       _Escribir_Digito+0
;voltimetro.mpas,29 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,30 :: 		UART_Write_Char('V');
	MOVLW      86
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,31 :: 		UART_Write_Char('O');
	MOVLW      79
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,32 :: 		UART_Write_Char('L');
	MOVLW      76
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,33 :: 		UART_Write_Char('T');
	MOVLW      84
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,34 :: 		UART_Write_Char('S');
	MOVLW      83
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,35 :: 		end;
L_end_Escribir_Canal:
	RETURN
; end of _Escribir_Canal

_Escribir_Espacios:

;voltimetro.mpas,40 :: 		begin
;voltimetro.mpas,41 :: 		for i := 1 to cantidad do
	MOVLW      1
	MOVWF      Escribir_Espacios_i+0
L__Escribir_Espacios3:
	MOVF       Escribir_Espacios_i+0, 0
	SUBWF      FARG_Escribir_Espacios_cantidad+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__Escribir_Espacios7
;voltimetro.mpas,42 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
	MOVF       Escribir_Espacios_i+0, 0
	XORWF      FARG_Escribir_Espacios_cantidad+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__Escribir_Espacios7
	INCF       Escribir_Espacios_i+0, 1
	GOTO       L__Escribir_Espacios3
L__Escribir_Espacios7:
;voltimetro.mpas,43 :: 		end;
L_end_Escribir_Espacios:
	RETURN
; end of _Escribir_Espacios

_Escribir_Separador:

;voltimetro.mpas,46 :: 		begin
;voltimetro.mpas,48 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,49 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,50 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,51 :: 		UART_Write_Char('-');
	MOVLW      45
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,52 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,53 :: 		UART_Write_Char(' ');
	MOVLW      32
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;voltimetro.mpas,54 :: 		end;
L_end_Escribir_Separador:
	RETURN
; end of _Escribir_Separador

_Escribir_Linea:

;voltimetro.mpas,57 :: 		begin
;voltimetro.mpas,64 :: 		Escribir_Canal(canal_a, raw_a);
	MOVF       FARG_Escribir_Linea_canal_a+0, 0
	MOVWF      FARG_Escribir_Canal_canal+0
	MOVF       FARG_Escribir_Linea_raw_a+0, 0
	MOVWF      FARG_Escribir_Canal_adc_raw+0
	MOVF       FARG_Escribir_Linea_raw_a+1, 0
	MOVWF      FARG_Escribir_Canal_adc_raw+1
	CALL       _Escribir_Canal+0
;voltimetro.mpas,65 :: 		Escribir_Separador();
	CALL       _Escribir_Separador+0
;voltimetro.mpas,66 :: 		Escribir_Canal(canal_b, raw_b);
	MOVF       FARG_Escribir_Linea_canal_b+0, 0
	MOVWF      FARG_Escribir_Canal_canal+0
	MOVF       FARG_Escribir_Linea_raw_b+0, 0
	MOVWF      FARG_Escribir_Canal_adc_raw+0
	MOVF       FARG_Escribir_Linea_raw_b+1, 0
	MOVWF      FARG_Escribir_Canal_adc_raw+1
	CALL       _Escribir_Canal+0
;voltimetro.mpas,67 :: 		end;
L_end_Escribir_Linea:
	RETURN
; end of _Escribir_Linea

_main:

;voltimetro.mpas,69 :: 		begin
;voltimetro.mpas,70 :: 		Inicializar_ADC();
	CALL       _Inicializar_ADC+0
;voltimetro.mpas,71 :: 		UART_Init();
	CALL       _UART_Init+0
;voltimetro.mpas,73 :: 		while true do
L__main12:
;voltimetro.mpas,77 :: 		Escribir_Linea(Leer_ADC(0), 0, Leer_ADC(1), 1);
	MOVLW      1
	MOVWF      FARG_Leer_ADC_canal+0
	CALL       _Leer_ADC+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	CLRF       FARG_Leer_ADC_canal+0
	CALL       _Leer_ADC+0
	MOVF       R0+0, 0
	MOVWF      FARG_Escribir_Linea_raw_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Escribir_Linea_raw_a+1
	CLRF       FARG_Escribir_Linea_canal_a+0
	MOVLW      1
	MOVWF      FARG_Escribir_Linea_canal_b+0
	MOVF       FLOC__main+0, 0
	MOVWF      FARG_Escribir_Linea_raw_b+0
	MOVF       FLOC__main+1, 0
	MOVWF      FARG_Escribir_Linea_raw_b+1
	CALL       _Escribir_Linea+0
;voltimetro.mpas,78 :: 		Escribir_Linea(Leer_ADC(2), 2, Leer_ADC(3), 3);
	MOVLW      3
	MOVWF      FARG_Leer_ADC_canal+0
	CALL       _Leer_ADC+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      2
	MOVWF      FARG_Leer_ADC_canal+0
	CALL       _Leer_ADC+0
	MOVF       R0+0, 0
	MOVWF      FARG_Escribir_Linea_raw_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Escribir_Linea_raw_a+1
	MOVLW      2
	MOVWF      FARG_Escribir_Linea_canal_a+0
	MOVLW      3
	MOVWF      FARG_Escribir_Linea_canal_b+0
	MOVF       FLOC__main+0, 0
	MOVWF      FARG_Escribir_Linea_raw_b+0
	MOVF       FLOC__main+1, 0
	MOVWF      FARG_Escribir_Linea_raw_b+1
	CALL       _Escribir_Linea+0
;voltimetro.mpas,80 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L__main16:
	DECFSZ     R13+0, 1
	GOTO       L__main16
	DECFSZ     R12+0, 1
	GOTO       L__main16
	DECFSZ     R11+0, 1
	GOTO       L__main16
	NOP
	NOP
;voltimetro.mpas,81 :: 		end;
	GOTO       L__main12
;voltimetro.mpas,82 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
