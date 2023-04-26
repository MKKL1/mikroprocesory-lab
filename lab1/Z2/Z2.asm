//Poni¿ej podaj swoje dane
//<Imiê i nazwisko>
//<Nr indeksu>
//<Grupa studencka>
//<Grupa laboratoryjna>
//Cw2Z2
///////////////////////

.include "m32def.inc"
	
	.org 0x00
	jmp main

	.org 0x100
main: 			; program g³ówny
	;ustawiamy outputy
	sbi DDRA,0
	sbi DDRB,0
	sbi DDRC,0
	sbi DDRD,0

	;inputy na przyciski
	cbi DDRA,7
	cbi DDRD,7
 
	;podciagniecie linii wejsciowych do zasilania
	sbi PORTA,7
	sbi PORTD,7
 
	;ustawienie poczatkowego stanu ledow
	cbi PORTA,0
	sbi PORTB,0
	sbi PORTC,0
	sbi PORTD,0
loop:			; pocz¹tek pêtli g³ównej
	;znowu to zjebane przelaczanie wartosci
 
	;jak PINA jest na 1 czyli przycisk A jest NIE wcisniety to gasi leda
	sbis PINA,7 ;jak 1 to skip linie kodu
	rjmp led0on
	cbi PORTA,0
	rjmp buttonAend
led0on:
	sbi PORTA,0
buttonAend:
	;jak PIND jest na 0 czyli przycisk B jest wcisniety to gasi leda
	sbic PIND,7 ;jak 0 to skip linie kodu
	rjmp led4on
	cbi PORTD,0
	rjmp buttonBend
led4on:
	sbi PORTD,0
buttonBend:
	rjmp loop 	; wróæ na pocz¹tek pêtli g³ównej
