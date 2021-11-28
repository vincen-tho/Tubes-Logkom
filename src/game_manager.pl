/* FAKTA */

/* DINAMIS */
:- dynamic(time/1).
:- dynamic(lose/1).
:- dynamic(win/1).

/* RULES */
initializeTime :- assertz(time(0)).
/* addTime(X), yang dalam hal ini X adalah jumlah penambahan waktu */
addTime(X) :- time(OLD), 
    NEW is OLD+X,
    retract(time(OLD)), 
    assertz(time(NEW)),
    checkLoseCondition,
    checkIfUpdateRanch, !.
/* check lose condition, jika sudah 1200 jam dan gold belum 20000, kalah */
checkLoseCondition :-   time(CURRENTTIME),
                        CURRENTTIME >= 1200,
                        win(WINSTATUS),
                        lose(LOSESTATUS),
                        gold(GOLD),
                        WINSTATUS =:= 0,
                        LOSESTATUS =:= 0,
                        GOLD < 20000,
                        retract(lose(LOSESTATUS)),
                        assertz(lose(1)),
                        write('You have worked hard, but in the end result is all that matters.'), nl, write('May God bless you in the future with kind people!'), nl, !.
checkLoseCondition :-   !.

/* check win condition, jika gold sudah 20000, menang */
checkWinCondition :-    win(WINSTATUS),
                        lose(LOSESTATUS),
                        gold(GOLD),
                        WINSTATUS =:= 0,
                        LOSESTATUS =:= 0,
                        GOLD >= 20000,
                        retract(win(WINSTATUS)),
                        assertz(win(1)),
                        write('Congratulations! You have finally collected 20000 golds!'), nl, !.
checkWinCondition :-    !.

/* ini untuk ngecek ranching */
checkIfUpdateRanch :-   time(X),
                        CHECK is X mod 24,
                        CHECK =:= 0,
                        updateRanch, !.
checkIfUpdateRanch :-   !.
printTime :- 
    time(X),
    Day is X//24,
    Hour is X mod 24,
    write('It is day '), print(Day), nl,
    write('It is hour '), print(Hour).