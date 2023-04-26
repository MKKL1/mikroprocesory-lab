;pod³¹czenie przycisków PB0 do W1 i PD0 do W2, a GND do K1
;natomiast PA0-PA7 do D0-D7
.include "m32def.inc"
	
	.org 0x00
	jmp main

	.org 0x100
main: 			; program g³ówny
	;ustawienie linii 0 portu B i D na wejœcie
	cbi DDRB, 0
	cbi DDRD, 0

	;podci¹gniecie przycisków do zasilania
	sbi PORTB, 0
	sbi PORTD, 0

	;ustawienie wszystkich linii portu A na wyjœcie
	ldi r16, 0b11111111
	out DDRA, r16

	ldi r17, 0b00000001 ;ustawienie pocz¹tkowej pozycji licznika
	mov r19, r17 ;kopiowanie licznika do innego rejestru przed pierwszym wyœwietleniem
	
	;sta³a dla INV
	ldi r18, 0b00011000

	;zainicjowanie stosu
	ldi r16, high(RAMEND)
	out SPH, r16
	ldi r16, low(RAMEND)
	out SPL, r16
	sei
loop:			; pocz¹tek pêtli g³ównej
	sbis PINB, 0 ;jezeli przycisk STOP jest wcisniety to przechodzi na koniec pêtli
	rjmp koniecpetli

	out PORTA, r19 ;wyœwietlenie kopii licznika
	lsl r17 ;przesuniêcie w lewo
	breq reset ;reset pozycji jezeli lsl ustawi r17 na 0x00
	
	mov r19,r17 ;kopiowanie do innego rejestru by modifikowaæ kopie licznika
	sbic PIND, 0 ;jezeli przycisk INV jest wcisniety to omija przejscie na koniec petli
	rjmp koniecpetli

	eor r19, r18 ;odwrócenie bitu 3 i 4 w kopii

	rjmp koniecpetli
reset:
	ldi r17, 0b00000001 ;powrót do stanu pocz¹tkowego
	mov r19, r17 ;kopia do pomocniczego rejestru
koniecpetli:
	call delay
	rjmp loop 	; wróæ na pocz¹tek pêtli g³ównej

delay:
	ldi  r20, 2
    ldi  r21, 4
    ldi  r22, 187
L1: dec  r22
    brne L1
    dec  r21
    brne L1
    dec  r20
    brne L1
	ret