;pod��czono GND do K1
;oraz od PA0 do W1, PA7 do W2
;linie portu A od 2 do 5 w��cznie s� pod��czone do LED0-LED3

.include "m32def.inc"
	
	.org 0x00
	jmp main

	.org 0x100
main: 			; program g��wny
	;ustawienie linii 2-5 portu A na wyj�cie
	in r16, DDRA
	ori r16, 0b00111100
	out DDRA, r16

	;ustawienie linii 0 i 7 portu A na wej�cie
	cbi DDRA,0
	cbi DDRA,7

	;podci�gni�cie linii wej�ciowych do zasilania
	sbi PORTA,0
	sbi PORTA,7

loop:			; pocz�tek p�tli g��wnej
	in r16, PINA ;wczytujemy wartosci z PINA
	com r16 ;odwrocenie by sprawdzic czy bit 0 i 7 s� zerem
	andi r16, 0b10000001 ;zerowanie bitow 1-6
	breq obaniewcisniete ;jezeli r16 jest wyzerowane to znaczy ze wszystkie przyciski sa 
	
	;ka�dy inny przypadek
	in r16, PORTA
	andi r16, 0b11001111 ;zerowanie bit�w 5 i 6
	ori r16, 0b00001100 ;ustawienie bit�w 2 i 3
	out PORTA, r16 ;ustawienie PORTA
	;uzyskano |ON|ON|OFF|OFF|

	rjmp loop
obaniewcisniete:
	
	in r16, PORTA
	andi r16, 0b11110011 ;zerowanie bit�w 2 i 3
	ori r16, 0b00110000 ;ustawianie bit�w 4 i 5
	out PORTA, r16 ;ustawienie PORTA
	;uzyskany efekt OFF|OFF|ON|ON

	rjmp loop 	; wr�� na pocz�tek p�tli g��wnej

