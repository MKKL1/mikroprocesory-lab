;pod³¹czono GND do K1
;oraz od PA0 do W1, PA7 do W2
;linie portu A od 2 do 5 w³¹cznie s¹ pod³¹czone do LED0-LED3

.include "m32def.inc"
	
	.org 0x00
	jmp main

	.org 0x100
main: 			; program g³ówny
	;ustawienie linii 2-5 portu A na wyjœcie
	in r16, DDRA
	ori r16, 0b00111100
	out DDRA, r16

	;ustawienie linii 0 i 7 portu A na wejœcie
	cbi DDRA,0
	cbi DDRA,7

	;podci¹gniêcie linii wejœciowych do zasilania
	sbi PORTA,0
	sbi PORTA,7

loop:			; pocz¹tek pêtli g³ównej
	in r16, PINA ;wczytujemy wartosci z PINA
	com r16 ;odwrocenie by sprawdzic czy bit 0 i 7 s¹ zerem
	andi r16, 0b10000001 ;zerowanie bitow 1-6
	breq obaniewcisniete ;jezeli r16 jest wyzerowane to znaczy ze wszystkie przyciski sa 
	
	;ka¿dy inny przypadek
	in r16, PORTA
	andi r16, 0b11001111 ;zerowanie bitów 5 i 6
	ori r16, 0b00001100 ;ustawienie bitów 2 i 3
	out PORTA, r16 ;ustawienie PORTA
	;uzyskano |ON|ON|OFF|OFF|

	rjmp loop
obaniewcisniete:
	
	in r16, PORTA
	andi r16, 0b11110011 ;zerowanie bitów 2 i 3
	ori r16, 0b00110000 ;ustawianie bitów 4 i 5
	out PORTA, r16 ;ustawienie PORTA
	;uzyskany efekt OFF|OFF|ON|ON

	rjmp loop 	; wróæ na pocz¹tek pêtli g³ównej

