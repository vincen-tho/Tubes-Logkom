/* Include */
:- include('player.pl').

/* Dynamic */
:- dynamic(fishProbability/1).
:- dynamic(gainedExpNoFish/1).
:- dynamic(gainedExpFish/1).

/* RULES */ 
/* Inisialisasi kondisi fishing */
/* Fish probability bergantung pada level fishing player */
/* Semakin tinggi levelnya, kesempatan mendapatkan ikan yang langka/mahal meningkat. */
initFishing :- 
    /* Angka di bawah hanya sebagai sample */
    playerFishingLevel(X),
    Y is (X-1)*0.002,
    Z is (X-1)*2,
    Y1 is 0.2-Y, Y2 is 0.5-Y, Y3 is 0.15-Y, Y4 is 0.04+Y, Y5 is 0.03+Y, Y6 is 0.005+Y,
    Z1 is 5+Z, Z2 is 10+Z,
    assertz(fishProbability([Y1, Y2, Y3, 0.075, Y4, Y5, Y6])),
    assertz(gainedExpNoFish(Z1)),
    assertz(gainedExpFish(Z2)).

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

/* Fishing */
/* TODO: tambah pengecekan posisi player, sedang berada di dekat tile air atau tidak */
fishing :- 
    initFishing, 
    fishProbability(_X),
    choice(['none', 'bottle', 'catfish', 'cod', 'salmon', 'tuna', 'puffer fish'], _X, Y),
    (Y = 'none' -> write('You didn\'t get anything!'), nl, 
    gainedExpNoFish(Z), 
    write('You gained '), write(Z), write(' some fishing exp!');
    write('You got '), write(Y), write('!'), nl, 
    gainedExpFish(Z), 
    write('You gained '), write(Z), write(' fishing exp!')).

/* 
TODO: 
    - menambah hasil tangkapan ke inventory 
    - exp fishing dan overal ditambah 
*/