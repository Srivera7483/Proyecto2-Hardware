
_UART_Init:

;lcd_serial.mpas,11 :: 		begin
;lcd_serial.mpas,12 :: 		CMCON := 7;       // Comparadores apagados
	MOVLW      7
	MOVWF      CMCON+0
;lcd_serial.mpas,13 :: 		TRISIO.B5 := 0;   // GP5 como salida
	BCF        TRISIO+0, 5
;lcd_serial.mpas,14 :: 		TX_PIN := 1;      // UART en reposo = 1
	BSF        GPIO+0, 5
;lcd_serial.mpas,15 :: 		end;
L_end_UART_Init:
	RETURN
; end of _UART_Init

_UART_Write_Char:

;lcd_serial.mpas,20 :: 		begin
;lcd_serial.mpas,22 :: 		TX_PIN := 0;
	BCF        GPIO+0, 5
;lcd_serial.mpas,23 :: 		Delay_us(417);    // 2400 baud aprox.
	MOVLW      138
	MOVWF      R13+0
L__UART_Write_Char2:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char2
	NOP
	NOP
;lcd_serial.mpas,26 :: 		for i := 0 to 7 do
	CLRF       R2+0
L__UART_Write_Char4:
;lcd_serial.mpas,28 :: 		if (c and 1) = 1 then
	MOVLW      1
	ANDWF      FARG_UART_Write_Char_c+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__UART_Write_Char9
;lcd_serial.mpas,29 :: 		TX_PIN := 1
	BSF        GPIO+0, 5
	GOTO       L__UART_Write_Char10
;lcd_serial.mpas,30 :: 		else
L__UART_Write_Char9:
;lcd_serial.mpas,31 :: 		TX_PIN := 0;
	BCF        GPIO+0, 5
L__UART_Write_Char10:
;lcd_serial.mpas,33 :: 		c := c shr 1;
	RRF        FARG_UART_Write_Char_c+0, 1
	BCF        FARG_UART_Write_Char_c+0, 7
;lcd_serial.mpas,34 :: 		Delay_us(417);
	MOVLW      138
	MOVWF      R13+0
L__UART_Write_Char11:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char11
	NOP
	NOP
;lcd_serial.mpas,35 :: 		end;
	MOVF       R2+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Write_Char7
	INCF       R2+0, 1
	GOTO       L__UART_Write_Char4
L__UART_Write_Char7:
;lcd_serial.mpas,38 :: 		TX_PIN := 1;
	BSF        GPIO+0, 5
;lcd_serial.mpas,39 :: 		Delay_us(417);
	MOVLW      138
	MOVWF      R13+0
L__UART_Write_Char12:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char12
	NOP
	NOP
;lcd_serial.mpas,42 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L__UART_Write_Char13:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char13
;lcd_serial.mpas,43 :: 		end;
L_end_UART_Write_Char:
	RETURN
; end of _UART_Write_Char
