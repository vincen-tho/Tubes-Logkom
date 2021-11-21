/* Include */

/* Dynamic */
:- dynamic(fishProbability/1).

/* Fish probability bergantung pada level fishing player */
/* Semakin tinggi levelnya, kesempatan mendapatkan ikan yang langka/mahal meningkat. */
/* TODO: menghubungkan fishing level player dengan peningkatan probability untuk ikan yang mahal/langka*/ 
initFishing :- 
    retractall(fishProbability(_)),
    /* Rasio di bawah hanya sebagai sample */
    assertz(fishProbability([0.2, 0.5, 0.15, 0.075, 0.04, 0.03, 0.005])).

/* Random pick element list */
/* Source: https://stackoverflow.com/questions/50250234/prolog-how-to-non-uniformly-randomly-select-a-element-from-a-list */
choice([X|_], [P|_], Cumul, Rand, X) :-
    Rand < Cumul + P.
choice([_|Xs], [P|Ps], Cumul, Rand, Y) :-
    Cumul1 is Cumul + P,
    Rand >= Cumul1,
    choice(Xs, Ps, Cumul1, Rand, Y).
choice([X], [P], Cumul, Rand, X) :-
    Rand < Cumul + P.

choice(Xs, Ps, Y) :- random(R), choice(Xs, Ps, 0, R, Y).

/* RULES */ 
/* TODO: menghubungkan fishing level dan exp */
/* 'some' di bawah diganti dengan fishing exp yang bersesuaian dengan fishing level dan juga dapat tidaknya ikan */
fishing :- 
    initFishing, 
    fishProbability(_X),
    choice(['none', 'bottle', 'catfish', 'cod', 'salmon', 'tuna', 'puffer fish'], _X, Y),
    (Y = 'none' -> write('You didn\'t get anything!'), nl, write('You gained some fishing exp!');
    write('You got '), write(Y), write('!'), nl, write('You gained some fishing exp!')).