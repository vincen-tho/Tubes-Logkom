/* FAKTA */

/* DINAMIS */
:- dynamic(time/1).

/* RULES */
initializeTime :- assertz(time(0)).
/* addTime(X), yang dalam hal ini X adalah jumlah penambahan waktu */
addTime(X) :- time(OLD), NEW is OLD+X, retract(time(OLD)), assertz(time(NEW)).