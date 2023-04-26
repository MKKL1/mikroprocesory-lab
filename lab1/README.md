Poniższe zadania przeznaczone są do samodzielnego wykonania przez Studentów na zajęciach z użyciem Atmel Studio 7.0 i systemu uruchomieniowego zl3avr


Wszystkie programy mają być napisane w języku asemblera dla procesora AVR, uruchomione i przetestowane.

# Treści zadań:

We wszystkich poniższych zadaniach uwzględnia się, że w rzeczywistym układzie jeden z zacisków każdego z używanych przycisków dołączony jest do odpowiedniej linii portu,
a drugi do masy układu. W konsekwencji przyciśnięcie przycisku powoduje zwarcie linii portu do masy (wymuszenie 0 na linii wejściowej). 


Gdy przycisk pozostaje niewciśnięty linia wejściowa portu jest niespolaryzowana i rozpoznawany jej stan logiczny jest nieokreślony. W celu spowodowania, że w tym stanie przycisku stan linii wejściowej
jest 1 należy programowo taką linię wejściową "podciągnąć do zasilania". 


UWAGA! Dla celów programowej realizacji opóźnienia założyć, że mikrokontroler taktowany jest zegarem systemowym o częstotliwości 1MHz.
UWAGA! Programy skonstruować tak, żeby kod zawierał możliwie mało instrukcji, zwłaszcza nie powielał bloków o identycznym kodzie. 
W szczególności konstruując program o wariantowym sposobie działania nie używać oddzielnych bloków kodu na realizację poszczególnych wariantów, 
ponieważ skutkiem takiego sposobu jest niedopuszczalna multiplikacja znaczącej częsci kodu takich bloków!


## Zadanie 1
Opracować, uruchomić i przetestować program powodujący, że w trakcie, gdy przycisk dołączony do linii PA.1 jest niewciśnięty, dioda LED dołączona do linii
 PA.0 NIE ŚWIECI. Gdy gdy przycisk dołączony do linii PA.1 jest wciśnięty, dioda LED dołączona do linii PA.0 wykonuje cyklicznie następującą animację:

* krok #1 - dioda LED świeci przez 500ms,

* krok #2 - dioda LED nie świeci przez 500ms.

W każdym kroku animacji program jednokrotnie sprawdza stan przycisku i reaguje, jak wyżej. Użyć rozkazów operujących na pojedynczych bitach.
Do realizacji opóźnienia użyć pętli opóźniającej/ych umieszczonej/ych w odpowiednch miejscach w kodzie programu.
Przykładowy generator pętli opóźniającej dla AVR można znaleźć pod adresem: http://darcy.rsgc.on.ca/ACES/TEI4M/AVRdelay.html
Poza pętlami opóźnienia używać (w miarę możliwości) rozkazów operujących na pojedynczych bitach.
W celu zorganizowania programu nie należy używać procedur.  

## Zadanie 2
Do mikrokontrolera dołączone są diody LED w nastepujący sposób: LED0|LED1|LED2|LED3	-	PA0(PortA)|PB0(PortB)|PC0(PortC)|PD0(PortD).
Do linii 7  w Port A dołączony jest przycisk "A", natomiast do linii 7 w Port D dołączony jest przycisk "B".
Opracować program powodujący, że w zależności od stanu przycisków świecenie diod LED jest następujące:
* przyciski nieprzyciśnięte:
	OFF|ON|ON|ON
* przycisk A przyciśnięty (niezależnie od stanu przycisku B)
	dioda podłączona do PA0 pozostaje w stanie ON
* przycisk B przyciśnięty (niezależnie od stanu przycisku A)
	dioda podłączona do PD0 pozostaje w stanie OFF
Używać rozkazów operujących na pojedynczych bitach. W celu zorganizowania programu nie należy używać procedur.


