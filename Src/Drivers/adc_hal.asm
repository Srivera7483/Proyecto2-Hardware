
_Inicializar_ADC:

;adc_hal.mpas,9 :: 		begin
;adc_hal.mpas,10 :: 		CMCON := 7;
	MOVLW      7
	MOVWF      CMCON+0
;adc_hal.mpas,11 :: 		ANSEL := %00011111;
	MOVLW      31
	MOVWF      ANSEL+0
;adc_hal.mpas,12 :: 		GPIO.B5 := 1;
	BSF        GPIO+0, 5
;adc_hal.mpas,13 :: 		TRISIO := %00011111;
	MOVLW      31
	MOVWF      TRISIO+0
;adc_hal.mpas,14 :: 		ADCON0 := %10000001;
	MOVLW      129
	MOVWF      ADCON0+0
;adc_hal.mpas,15 :: 		end;
L_end_Inicializar_ADC:
	RETURN
; end of _Inicializar_ADC

_Leer_ADC:

;adc_hal.mpas,18 :: 		begin
;adc_hal.mpas,19 :: 		if canal > 3 then
	MOVF       FARG_Leer_ADC_canal+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L__Leer_ADC3
;adc_hal.mpas,20 :: 		canal := 0;
	CLRF       FARG_Leer_ADC_canal+0
L__Leer_ADC3:
;adc_hal.mpas,22 :: 		ADCON0 := ADCON0 and %11110011;
	MOVLW      243
	ANDWF      ADCON0+0, 1
;adc_hal.mpas,23 :: 		ADCON0 := ADCON0 or (canal shl 2);
	MOVF       FARG_Leer_ADC_canal+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      ADCON0+0, 1
;adc_hal.mpas,24 :: 		Delay_us(20);
	MOVLW      6
	MOVWF      R13+0
L__Leer_ADC5:
	DECFSZ     R13+0, 1
	GOTO       L__Leer_ADC5
	NOP
;adc_hal.mpas,25 :: 		ADCON0.B1 := 1;
	BSF        ADCON0+0, 1
;adc_hal.mpas,26 :: 		while (ADCON0.B1 = 1) do
L__Leer_ADC7:
	BTFSS      ADCON0+0, 1
	GOTO       L__Leer_ADC8
;adc_hal.mpas,28 :: 		nop;
	NOP
;adc_hal.mpas,29 :: 		end;
	GOTO       L__Leer_ADC7
L__Leer_ADC8:
;adc_hal.mpas,30 :: 		Result := (word(ADRESH) shl 8) or ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	MOVF       R3+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 0
	MOVWF      R5+0
	MOVF       R0+1, 0
	MOVWF      R5+1
	MOVLW      0
	IORWF      R5+1, 1
;adc_hal.mpas,31 :: 		end;
	MOVF       R5+0, 0
	MOVWF      R0+0
	MOVF       R5+1, 0
	MOVWF      R0+1
L_end_Leer_ADC:
	RETURN
; end of _Leer_ADC
