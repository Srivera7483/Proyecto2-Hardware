
_main:

;voltimetro.mpas,5 :: 		begin
;voltimetro.mpas,6 :: 		Inicializar_ADC();
	CALL       _Inicializar_ADC+0
;voltimetro.mpas,7 :: 		UART_Init();
	CALL       _UART_Init+0
;voltimetro.mpas,8 :: 		while true do
L__main2:
	GOTO       L__main2
;voltimetro.mpas,11 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
