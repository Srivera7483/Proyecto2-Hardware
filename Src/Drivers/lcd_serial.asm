
_UART_Init:

;lcd_serial.mpas,12 :: 		begin
;lcd_serial.mpas,13 :: 		TX_PIN := 1;
	BSF        GPIO+0, 5
;lcd_serial.mpas,14 :: 		end;
L_end_UART_Init:
	RETURN
; end of _UART_Init

_UART_Write_Char:

;lcd_serial.mpas,19 :: 		begin
;lcd_serial.mpas,20 :: 		TX_PIN := 0;
	BCF        GPIO+0, 5
;lcd_serial.mpas,21 :: 		Delay_us(104);
	MOVLW      34
	MOVWF      R13+0
L__UART_Write_Char2:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char2
	NOP
;lcd_serial.mpas,23 :: 		for i := 0 to 7 do
	CLRF       R2+0
L__UART_Write_Char4:
;lcd_serial.mpas,25 :: 		if (c and 1) = 1 then
	MOVLW      1
	ANDWF      FARG_UART_Write_Char_c+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__UART_Write_Char9
;lcd_serial.mpas,26 :: 		TX_PIN := 1
	BSF        GPIO+0, 5
	GOTO       L__UART_Write_Char10
;lcd_serial.mpas,27 :: 		else
L__UART_Write_Char9:
;lcd_serial.mpas,28 :: 		TX_PIN := 0;
	BCF        GPIO+0, 5
L__UART_Write_Char10:
;lcd_serial.mpas,29 :: 		c := c shr 1;
	RRF        FARG_UART_Write_Char_c+0, 1
	BCF        FARG_UART_Write_Char_c+0, 7
;lcd_serial.mpas,30 :: 		Delay_us(104);
	MOVLW      34
	MOVWF      R13+0
L__UART_Write_Char11:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char11
	NOP
;lcd_serial.mpas,31 :: 		end;
	MOVF       R2+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Write_Char7
	INCF       R2+0, 1
	GOTO       L__UART_Write_Char4
L__UART_Write_Char7:
;lcd_serial.mpas,33 :: 		TX_PIN := 1;
	BSF        GPIO+0, 5
;lcd_serial.mpas,34 :: 		Delay_us(104);
	MOVLW      34
	MOVWF      R13+0
L__UART_Write_Char12:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char12
	NOP
;lcd_serial.mpas,35 :: 		Delay_us(100);
	MOVLW      33
	MOVWF      R13+0
L__UART_Write_Char13:
	DECFSZ     R13+0, 1
	GOTO       L__UART_Write_Char13
;lcd_serial.mpas,36 :: 		end;
L_end_UART_Write_Char:
	RETURN
; end of _UART_Write_Char

_UART_Write_Text:

;lcd_serial.mpas,41 :: 		begin
;lcd_serial.mpas,42 :: 		i := 0;
	CLRF       UART_Write_Text_i+0
;lcd_serial.mpas,43 :: 		while (texto[i] <> 0) do
L__UART_Write_Text16:
	MOVF       UART_Write_Text_i+0, 0
	ADDWF      FARG_UART_Write_Text_texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__UART_Write_Text17
;lcd_serial.mpas,45 :: 		UART_Write_Char(texto[i]);
	MOVF       UART_Write_Text_i+0, 0
	ADDWF      FARG_UART_Write_Text_texto+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART_Write_Char_c+0
	CALL       _UART_Write_Char+0
;lcd_serial.mpas,46 :: 		Inc(i);
	INCF       UART_Write_Text_i+0, 1
;lcd_serial.mpas,47 :: 		end;
	GOTO       L__UART_Write_Text16
L__UART_Write_Text17:
;lcd_serial.mpas,48 :: 		end;
L_end_UART_Write_Text:
	RETURN
; end of _UART_Write_Text
