#include <avr/io.h>
#include <avr/interrupt.h>
#define F_CPU 1000000LU
#include <util/delay.h>
#include <avr/pgmspace.h>


//Tablica transkodowania
const uint8_t tablicaznakow[17] PROGMEM = {
	0b11000000,//0
	0b11111001,//1
	0b10100100,//2
	0b10110000,//3
	0b10011001,//4
	0b10010010,//5
	0b10000010,//6
	0b11111000,//7
	0b10000000,//8
	0b10011000,//9
	0b10001000,//A
	0b10000011,//b
	0b11000110,//C
	0b10100001,//d
	0b10000110,//E
	0b10001110,//F
	0b11111111//nic
};

void dodaj_cyfre(uint8_t cyfra);


uint8_t cyfry[4] = {16, 16, 16, 16};
volatile uint8_t licznik = 0;
volatile uint8_t ostatni_stan[4] = {0xff, 0xff, 0xff, 0xff};
ISR(TIMER0_COMP_vect) {
	uint8_t w = 0xff;
	
	PORTD &= ~(1 << licznik+4);
	_delay_us(10);
	w = PIND | 0xf0;
	PORTD |= (1 << licznik+4);
	
	uint8_t zmianastanu = (ostatni_stan[licznik] & ~w);
	if (zmianastanu != 0x00) {
		uint8_t wLicznik = 0;
		while(zmianastanu != (1 << wLicznik))
		{
			wLicznik++;
		}
		uint8_t liczba = wLicznik*4+licznik;
		if(liczba <= 9) {
			dodaj_cyfre(liczba);
		}
		
	}
	
	PORTA = pgm_read_byte(&(tablicaznakow[cyfry[licznik]]));
	
	
	ostatni_stan[licznik] = w;
	licznik = (licznik+1) & 0b00000011;
}

void dodaj_cyfre(uint8_t liczba) {
	uint8_t i;
	for(i = 0; i < 3; i++) {
		cyfry[i] = cyfry[i+1]; 
	}
	cyfry[3] = liczba;
	for(i = 0; i < 4; i++) {
		if (cyfry[i] == 0 || cyfry[i] == 16) {
			cyfry[i] = 16;
		} else break;
	}
}

int main(void)
{
	DDRA = 0xFF;
	
	DDRA = 0xff;
	DDRD = 0xf0;
	PORTD = 0xff;
	
	DDRB = 0xff;
	
	//			prescaler 64			tryb CTC
	TCCR0 |= (1 << CS00) | (1 << CS01) | (1 << WGM01);
	OCR0 = 195;//125ms
	
	//Aktywacja przerwania TIMER0_COMP_vect
	TIMSK |= (1 << OCIE0);
	
	//Globalna aktywacja przerwa?
	sei();
	
	while (1)
	{
		asm("nop");
	}
}
