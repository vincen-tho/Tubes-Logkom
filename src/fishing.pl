/* Dynamic */
:- dynamic(fishProbability/1).
:- dynamic(gainedExpNoFish/1).
:- dynamic(gainedExpFish/1).

/* RULES */ 
/* Cek posisi player, berada di dekat tile air atau tidak */
checkPosWater :-
    playerPos(X, Y),
    X1 is X+1, X2 is X-1, Y1 is Y+1, Y2 is Y-1,
    (specialTile(X1,Y,'W'); specialTile(X2,Y,'W'); specialTile(X,Y1,'W'); specialTile(X,Y2,'W');
    specialTile(X1,Y1,'W'); specialTile(X1,Y2,'W'); specialTile(X2,Y1,'W'); specialTile(X2,Y2,'W');
    write('You aren\'t near water!'), fail).

/* Inisialisasi kondisi fishing */
/* Fish probability bergantung pada level fishing player */
/* Semakin tinggi levelnya, kesempatan mendapatkan ikan yang langka/mahal meningkat. */
initFishing :- 
    retractall(fishProbability(_)), retractall(gainedExpNoFish(_)), retractall(gainedExpFish(_)),
    playerFishingLevel(X),
    Y is X*0.002,
    Z is X*2,
    Y1 is 0.22-Y, Y2 is 0.3-Y, Y3 is 0.17-Y, Y4 is 0.1+Y, Y5 is 0.06+Y, Y6 is 0.01+Y,
    (Y1 < 0.14; Y2 < 0.14; Y3 < 0.14; Y4 < 0.14; Y5 < 0.14; Y6 < 0.14),
    Y1 is 0.22+Y, Y2 is 0.3+Y, Y3 is 0.17+Y, Y4 is 0.1-Y, Y5 is 0.06-Y, Y6 is 0.01-Y,
    Z1 is 5+Z, Z2 is 10+Z,
    assertz(fishProbability([Y1, Y2, Y3, 0.14, Y4, Y5, Y6])),
    assertz(gainedExpNoFish(Z1)),
    assertz(gainedExpFish(Z2)), !.
initFishing :- 
    retractall(fishProbability(_)), retractall(gainedExpNoFish(_)), retractall(gainedExpFish(_)),
    playerFishingLevel(X),
    Y is X*0.002,
    Z is X*2,
    Y1 is 0.22-Y, Y2 is 0.3-Y, Y3 is 0.17-Y, Y4 is 0.1+Y, Y5 is 0.06+Y, Y6 is 0.01+Y,
    Z1 is 5+Z, Z2 is 10+Z,
    assertz(fishProbability([Y1, Y2, Y3, 0.14, Y4, Y5, Y6])),
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
fishing :- 
    checkPosWater,
    initFishing, 
    fishProbability(_X),
    choice(['none', 'Bottle', 'Catfish', 'Cod', 'Salmon', 'Tuna', 'Puffer Fish'], _X, Y),
    (Y = 'none' -> write('You didn\'t get anything!'), nl, 
    gainedExpNoFish(Z), 
    write('You gained '), write(Z), write(' fishing exp!');
    write('You got '), write(Y), write('!'), nl, 
    gainedExpFish(Z), 
    write('You gained '), write(Z), write(' fishing exp!')),
    addFishingEXP(Z), addEXP(Z), addFishToInv(Y), !.

/* Menambah hasil tangkapan ke inventory */
addFishToInv([],_,[]).
addFishToInv([], Fish, [[Name, Qty]|[]]) :-
    Name = Fish,
    Qty is 1, !.
addFishToInv([[Name, Qty]|Tail], Fish, [[Name1, Qty1]|Tail1]) :-
    Fish = Name,
    addFishToInv(Tail, Fish, Tail1),
    Name1 = Name,
    Qty1 is Qty+1.
addFishToInv([[Name, Qty]|Tail], Fish, [[Name1, Qty1]|Tail1]) :-
    Fish \= Name,
    addFishToInv(Tail, Fish, Tail1),
    Name1 = Name,
    Qty1 is Qty.

addFishToInv(Fish) :-
    inventory(Inv),
    addFishToInv(Inv, Fish, Inv1),
    retractall(inventory(_)),
    assertz(inventory(Inv1)).