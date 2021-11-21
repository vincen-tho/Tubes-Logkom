/* Dynamic */
:- dynamic(totalChicken/1).
:- dynamic(totalSheep/1).
:- dynamic(totalCow/1).
:- dynamic(gainedExpRanch/1).

/* RULES */
/* Inisialisasi kondisi awal ranching */
initRanching :-
    assertz(totalChicken(0)),
    assertz(totalSheep(0)),
    assertz(totalCow(0)).

/* Ranch */
ranch :- 
    totalChicken(X),
    totalSheep(Y),
    totalCow(Z),
    write('Welcome to the ranch! You have:'), nl,
    write(X), write(' '), write(chicken), nl,    
    write(Y), write(' '), write(sheep), nl,    
    write(Z), write(' '), write(cow), nl, nl,
    write('What do you want to do?').   

/* Cek kondisi hewan ternak */
/* Command chicken mengecek apakah ayam bertelur atau sudah siap panen (ayam diambil untuk kemudian dikonsumsi) */
chicken :-
/* Command sheep mengecek apakah domba siap panen (domba diambil untuk kemudian dikonsumsi) atau bulunya siap dicukur (wool) */
sheep :-
/* Command cow mengecek apakah sapi siap panen (sapi diambil untuk kemudian dikonsumsi) atau siap diperah susunya */
cow :-