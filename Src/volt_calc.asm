
_ADC_A_CentiVoltios:

;volt_calc.mpas,13 :: 		begin
;volt_calc.mpas,14 :: 		if adc_raw > 1023 then
	MOVF       FARG_ADC_A_CentiVoltios_adc_raw+1, 0
	SUBLW      3
	BTFSS      STATUS+0, 2
	GOTO       L__ADC_A_CentiVoltios27
	MOVF       FARG_ADC_A_CentiVoltios_adc_raw+0, 0
	SUBLW      255
L__ADC_A_CentiVoltios27:
	BTFSC      STATUS+0, 0
	GOTO       L__ADC_A_CentiVoltios2
;volt_calc.mpas,15 :: 		adc_raw := 1023;
	MOVLW      255
	MOVWF      FARG_ADC_A_CentiVoltios_adc_raw+0
	MOVLW      3
	MOVWF      FARG_ADC_A_CentiVoltios_adc_raw+1
L__ADC_A_CentiVoltios2:
;volt_calc.mpas,17 :: 		i := 0;
	CLRF       R5+0
	CLRF       R5+1
;volt_calc.mpas,18 :: 		acumulador := 511;
	MOVLW      255
	MOVWF      R7+0
	MOVLW      1
	MOVWF      R7+1
;volt_calc.mpas,19 :: 		centi := 0;
	CLRF       R9+0
	CLRF       R9+1
;volt_calc.mpas,23 :: 		while i < adc_raw do
L__ADC_A_CentiVoltios5:
	MOVF       FARG_ADC_A_CentiVoltios_adc_raw+1, 0
	SUBWF      R5+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ADC_A_CentiVoltios28
	MOVF       FARG_ADC_A_CentiVoltios_adc_raw+0, 0
	SUBWF      R5+0, 0
L__ADC_A_CentiVoltios28:
	BTFSC      STATUS+0, 0
	GOTO       L__ADC_A_CentiVoltios6
;volt_calc.mpas,25 :: 		Inc(i);
	INCF       R5+0, 1
	BTFSC      STATUS+0, 2
	INCF       R5+1, 1
;volt_calc.mpas,26 :: 		acumulador := acumulador + 500;
	MOVLW      244
	ADDWF      R7+0, 0
	MOVWF      R1+0
	MOVF       R7+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      R7+0
	MOVF       R1+1, 0
	MOVWF      R7+1
;volt_calc.mpas,28 :: 		if acumulador >= 1023 then
	MOVLW      3
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ADC_A_CentiVoltios29
	MOVLW      255
	SUBWF      R1+0, 0
L__ADC_A_CentiVoltios29:
	BTFSS      STATUS+0, 0
	GOTO       L__ADC_A_CentiVoltios10
;volt_calc.mpas,30 :: 		acumulador := acumulador - 1023;
	MOVLW      255
	SUBWF      R7+0, 1
	BTFSS      STATUS+0, 0
	DECF       R7+1, 1
	MOVLW      3
	SUBWF      R7+1, 1
;volt_calc.mpas,31 :: 		Inc(centi);
	INCF       R9+0, 1
	BTFSC      STATUS+0, 2
	INCF       R9+1, 1
;volt_calc.mpas,32 :: 		end;
L__ADC_A_CentiVoltios10:
;volt_calc.mpas,33 :: 		end;
	GOTO       L__ADC_A_CentiVoltios5
L__ADC_A_CentiVoltios6:
;volt_calc.mpas,35 :: 		if centi > 500 then
	MOVF       R9+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__ADC_A_CentiVoltios30
	MOVF       R9+0, 0
	SUBLW      244
L__ADC_A_CentiVoltios30:
	BTFSC      STATUS+0, 0
	GOTO       L__ADC_A_CentiVoltios13
;volt_calc.mpas,36 :: 		centi := 500;
	MOVLW      244
	MOVWF      R9+0
	MOVLW      1
	MOVWF      R9+1
L__ADC_A_CentiVoltios13:
;volt_calc.mpas,38 :: 		Result := centi;
	MOVF       R9+0, 0
	MOVWF      R3+0
	MOVF       R9+1, 0
	MOVWF      R3+1
;volt_calc.mpas,39 :: 		end;
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
L_end_ADC_A_CentiVoltios:
	RETURN
; end of _ADC_A_CentiVoltios

_Voltaje_Digitos:

;volt_calc.mpas,44 :: 		begin
;volt_calc.mpas,45 :: 		centi := ADC_A_CentiVoltios(adc_raw);
	MOVF       FARG_Voltaje_Digitos_adc_raw+0, 0
	MOVWF      FARG_ADC_A_CentiVoltios_adc_raw+0
	MOVF       FARG_Voltaje_Digitos_adc_raw+1, 0
	MOVWF      FARG_ADC_A_CentiVoltios_adc_raw+1
	CALL       _ADC_A_CentiVoltios+0
	MOVF       R0+0, 0
	MOVWF      Voltaje_Digitos_centi+0
	MOVF       R0+1, 0
	MOVWF      Voltaje_Digitos_centi+1
;volt_calc.mpas,47 :: 		entero := 0;
	MOVF       FARG_Voltaje_Digitos_entero+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;volt_calc.mpas,48 :: 		while centi >= 100 do
L__Voltaje_Digitos17:
	MOVLW      0
	SUBWF      Voltaje_Digitos_centi+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Voltaje_Digitos32
	MOVLW      100
	SUBWF      Voltaje_Digitos_centi+0, 0
L__Voltaje_Digitos32:
	BTFSS      STATUS+0, 0
	GOTO       L__Voltaje_Digitos18
;volt_calc.mpas,50 :: 		centi := centi - 100;
	MOVLW      100
	SUBWF      Voltaje_Digitos_centi+0, 1
	BTFSS      STATUS+0, 0
	DECF       Voltaje_Digitos_centi+1, 1
;volt_calc.mpas,51 :: 		Inc(entero);
	MOVF       FARG_Voltaje_Digitos_entero+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_Voltaje_Digitos_entero+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;volt_calc.mpas,52 :: 		end;
	GOTO       L__Voltaje_Digitos17
L__Voltaje_Digitos18:
;volt_calc.mpas,54 :: 		dec1 := 0;
	MOVF       FARG_Voltaje_Digitos_dec1+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;volt_calc.mpas,55 :: 		while centi >= 10 do
L__Voltaje_Digitos22:
	MOVLW      0
	SUBWF      Voltaje_Digitos_centi+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Voltaje_Digitos33
	MOVLW      10
	SUBWF      Voltaje_Digitos_centi+0, 0
L__Voltaje_Digitos33:
	BTFSS      STATUS+0, 0
	GOTO       L__Voltaje_Digitos23
;volt_calc.mpas,57 :: 		centi := centi - 10;
	MOVLW      10
	SUBWF      Voltaje_Digitos_centi+0, 1
	BTFSS      STATUS+0, 0
	DECF       Voltaje_Digitos_centi+1, 1
;volt_calc.mpas,58 :: 		Inc(dec1);
	MOVF       FARG_Voltaje_Digitos_dec1+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_Voltaje_Digitos_dec1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;volt_calc.mpas,59 :: 		end;
	GOTO       L__Voltaje_Digitos22
L__Voltaje_Digitos23:
;volt_calc.mpas,61 :: 		dec2 := byte(centi);
	MOVF       FARG_Voltaje_Digitos_dec2+0, 0
	MOVWF      FSR
	MOVF       Voltaje_Digitos_centi+0, 0
	MOVWF      INDF+0
;volt_calc.mpas,62 :: 		end;
L_end_Voltaje_Digitos:
	RETURN
; end of _Voltaje_Digitos
