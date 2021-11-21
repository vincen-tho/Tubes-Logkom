/* FAKTA */

/* DINAMIS */
:- dynamic(time/1).

/* RULES */
initializeTime :- assertz(time(0)).
/* addTime(X), yang dalam hal ini X adalah jumlah penambahan waktu */
addTime(X) :- time(OLD), 
    NEW is OLD+X, 
    retract(time(OLD)), 
    assertz(time(NEW)).

printTime :- 
    time(X),
    Day is X//24,
    Hour is X mod 24,
    write('It is day '), print(Day), nl,
    write('It is hour '), print(Hour).