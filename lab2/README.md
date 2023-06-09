﻿Poniższe zadania przeznaczone są do samodzielnego wykonania przez Studentów na zajęciach z użyciem Atmel Studio 7.0 i systemu uruchomieniowego zl3avr
Wszystkie programy mają być napisane w języku asemblera dla procesora AVR, uruchomione i przetestowane.

# Treści zadań:

We wszystkich poniższych zadaniach uwzględnia się, że w rzeczywistym układzie jeden z zacisków każdego z używanych przycisków dołączony jest do 
odpowiedniej linii portu, a drugi do masy układu. W konsekwencji przyciśnięcie przycisku powoduje zwarcie linii portu do masy (wymuszenie 0 na linii 
wejściowej). Gdy przycisk pozostaje niewciśnięty linia wejściowa portu jest niespolaryzowana i rozpoznawany jej stan logiczny jest nieokreślony. W celu 
spowodowania, że w tym stanie przycisku stan linii wejściowej jest 1 należy programowo taką linię wejściową "podciągnąć do zasilania". 

## Zadanie 1
Do linii 0 i linii 7 Portu A mikrokontrolera dołączone są przyciski (wciśnięcie zwiera linię do 0). Do linii PA2-PA5 Portu A dołączone są
4-y diody linijki LED (PA2-PA5=D0-D3).

Opracować program powodujący, że gdy niewciśnięte są obydwa przyciski stan świecenia diod LED jest następujący |OFF|OFF|ON|ON|. 
(lewa skrajna pozycja w zapisie obok odpowiada diodzie umieszczonej po lewej stronie na zl3avr).

W każdym innym przypadku stan świecenia diod LED jest następujący |ON|ON|OFF|OFF|. 
Użyć rozkazów operujących na bajtach typu MOV, AND, OR, EOR, COM. Do stwierdzenia, że przyciśnięte są dwa przyciski użyć operacji maskowania, a do 
rozgałęzienia rozkazów typu BREQ/BRNE. Zaprogramowanie kierunków pracy w porcie niewykorzystującym wszystkich linii ma być wykonane tak, żeby dotychczasowe
 ustawienia kierunków pracy linii nieużywanych pozostały bez zmiany.

## Zadanie 2
Do Portu A mikrokontrolera dołączona jest "linijka" diod LED (PA0-PA7=D0-D7). Ponadto, że do linii 0 w porcie B dołączony jest przycisk
 "LED STOP", a do linii 0 w porcie D przycisk "LED3/4 - INV". 
Opracować, uruchomić i przetestować program powodujący animację świecenia diod LED i oddziaływanie przycisków na animację. 
Animacja polega na tym, że w każdej chwili świeci pojedyncza dioda LED przy czym, pozycja świecącej się diody cyklicznie się zmienia począwszy od dołączonej do PA.0,  
do diody dołączonej do PA.7, po czym sekwencja powtarza się w pętli nieskończonej. Czas świecenia na każdej pozycji wynosi 200ms.

Gdy przyciski są zwolnione, animacja trwa, jak w opisie powyżej. 

Gdy przycisk "LED STOP" jest wcisnięty, animacja ulega "zamrożeniu", jednakże co 200ms sprawdzany jest stan klawiszy i, po stwierdzeniu że przycisk "LED STOP" 
zwolniony, następuje kontynuacja animacji. 
 
Gdy przycisk "LED3/4 - INV" jest wcisnięty, stan świecenia diod D3 i D4 ulega zamianie na przeciwny, w stosunku do tego, jaki wynikałby z biegu bądź
zatrzymania animacji.

Użyć rozkazów operujących na bajtach typu MOV, AND, OR, EOR, rozkazów rotacji/przesunięć a także ewentualnie rozkazów operujących na pojedynczych bitach tak,
 żeby zminimalizować rozmiar i czas wykonywania kodu.
Konstruując program o wariantowym sposobie działania nie używać oddzielnych bloków kodu na realizację poszczególnych wariantów, ponieważ skutkiem takiego
 sposobu jest niedopuszczalna multiplikacja znaczącej częsci kodu takich bloków!

Użyć procedury zawierającej programową pętlę opóźnienia czasowego do wytworzenia opóźnienia. Należy przyjąć, że częstotliwość taktowania AVR wynosi 1 MHz.
Przykładowy generator pętli opóźniającej dla AVR można znaleźć pod adresem: http://darcy.rsgc.on.ca/ACES/TEI4M/AVRdelay.html

UWAGA! Należy pamiętać, że - jeżeli w AVR używane są procedury (także procedury obsługi przerwań), względnie rozkazy operujące na stosie, należy w części
inicjalizacyjnej programu zainicjalizować wskaźnik stosu. Właściwa sekwencja kroków podana jest w "ATMEGA32 Datasheet.pdf" (patrz pliki/Materiały 
informacyjne).

