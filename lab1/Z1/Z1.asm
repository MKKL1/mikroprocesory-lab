//Poni¿ej podaj swoje dane
//<Imiê i nazwisko>
//<Nr indeksu>
//<Grupa studencka>
//<Grupa laboratoryjna>
//Cw2Z1
///////////////////////

.include "m32def.inc"
	
	.org 0x00
	jmp main

	.org 0x100
main: 			; program g³ówny
   sbi DDRA,0 ;ustawienie na wyjscie linii 0 portu A
   cbi DDRA,1 ;ustawienie na wejscie linii 1 portu A
   sbi PORTA,1;podci¹gniecia linii wejsciowej
loop:			; pocz¹tek pêtli g³ównej
   sbic PINA,1 ;je¿eli bit 1 na PINA jest =0 to powtarza petle
   rjmp loop
 
   sbis PORTA,0 ;sprawdza czy led sie swieci, jezeli tak skipuje do ustawienia go na nie swiecenie(low/0)
   jmp setbit ;przeskakuje ustawienie na 0 bo chcemy tylko ustawic na 1
   cbi PORTA,0 ;ustawia zeby led sie nie swiecil, ustawia na 0
   jmp endset ;przeskakuje ustawienie na 1 bo juz ustawilismy na 0
setbit:
   sbi PORTA,0
endset:
   ;czekanie 500ms
   ldi  r18, 41
   ldi  r19, 150
   ldi  r20, 128
L1: dec  r20
   brne L1
   dec  r19
   brne L1
   dec  r18
   brne L1
   rjmp loop 	; wróæ na pocz¹tek pêtli g³ównej
